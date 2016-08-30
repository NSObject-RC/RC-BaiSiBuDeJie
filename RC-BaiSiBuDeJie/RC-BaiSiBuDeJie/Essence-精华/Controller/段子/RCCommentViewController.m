//
//  RCCommentViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/29.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCCommentViewController.h"
#import "RCDuanZiCell.h"
#import "RCDuanziModel.h"
#import "RCCommentModel.h"
#import "RCCommentHeadView.h"
@interface RCCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableV;
/** 工具条底部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;
/** 保存帖子的top_cmt */
@property (nonatomic, strong) RCCommentModel *saved_top_cmt;
@end

@implementation RCCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupTableViewHeadView];
    [self setupRefresh];

}
- (void)setupRefresh{
    self.tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableV.mj_header beginRefreshing];
}
- (void)loadNewComment{
    // 参数
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    params[@"a"]=@"dataList";
    params[@"c"]=@"comment";
    params[@"data_id"] = self.model.ID;
    params[@"hot"]=@"1";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //最热评论
        self.hotComments=[RCCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.latestComments =[RCCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableV reloadData];
        [self.tableV.mj_header endRefreshing];
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableV.mj_header endRefreshing];
    }];
}
- (void)setupTableViewHeadView{
    if(self.model.top_cmt){ // 不为0的话就是有最热评论
        self.saved_top_cmt=self.model.top_cmt;
        self.model.top_cmt = nil;
        [self.model setValue:@0 forKey:@"cellHeight"];
    }
    UIView * headV=[[UIView alloc]init];
    RCDuanZiCell * cell= [RCDuanZiCell cell];
    cell.moreBtn.hidden=YES;
    cell.model=self.model;
    cell.size=CGSizeMake(WIDTH, self.model.cellHeight);
    [headV addSubview:cell];
    headV.size=CGSizeMake(WIDTH, self.model.cellHeight);
    self.tableV.tableHeaderView=headV;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.model.top_cmt = self.saved_top_cmt;
    [self.model setValue:@0 forKey:@"cellHeight"];
}
- (void)setupTableView{
    self.navigationItem.title=@"评论";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" higtImage:@"comment_nav_item_share_icon_click" target:self action:@selector(moreBtuttonClick)];
    self.tableV.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)KeyboardWillChangeFrame:(NSNotification*)notifi{
    
    CGRect frame =[notifi.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    self.bottomSapce.constant=HEIGTH-frame.origin.y;
    
    CGFloat duration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark -----UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    // 非第0组
    return latestCount;
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) return 2; // 有"最热评论" + "最新评论" 2组
     else if (latestCount) return 1; // 有"最新评论" 1 组
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    RCCommentModel*model =[self commentInIndexPath:indexPath];
    cell.textLabel.text = model.content;
    return cell;
}

/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section{
    if(section==0){
        return self.hotComments.count ? self.hotComments :self.latestComments;
    }
    return self.latestComments;
}
- (RCCommentModel*)commentInIndexPath:(NSIndexPath *)indexPath{
    return [self commentsInSection:indexPath.section][indexPath.row];

}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView * headV=[[UIView alloc]init];
//    headV.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    UILabel * lab=[[UILabel alloc]init];
//    lab.width=200;
//    lab.autoresizingMask=UIViewAutoresizingFlexibleHeight;
//    lab.textColor=[UIColor redColor];
//    lab.x=RCCellMargin;
//    [headV addSubview:lab];
//    NSInteger hotCount = self.hotComments.count;
//        if (section == 0) {
//            lab.text = hotCount ? @"最热评论" : @"最新评论";
//        } else {
//            lab.text = @"最新评论";
//        }
//
//    return headV;
//}
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    static NSString * HeadID= @"head";
//    UITableViewHeaderFooterView * headV=[tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadID];
//    UILabel * lab=nil;
//    if(!headV){
//        headV=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:HeadID];
//        headV.contentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
//            lab=[[UILabel alloc]init];
//            lab.width=200;
//            lab.tag=99;
//            lab.autoresizingMask=UIViewAutoresizingFlexibleHeight;
//            lab.textColor=[UIColor greenColor];
//            lab.x=RCCellMargin;
//            [headV.contentView addSubview:lab];
//    }else{
//        lab=(UILabel*)[headV viewWithTag:99];
//    }
//    NSInteger hotCount = self.hotComments.count;
//            if (section == 0) {
//                lab.text = hotCount ? @"最热评论" : @"最新评论";
//            } else {
//                lab.text = @"最新评论";
//            }
//    
//    return headV ;
//}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RCCommentHeadView * headV=[RCCommentHeadView headerViewWithTableView:tableView];
    NSInteger hotCount = self.hotComments.count;
                if (section == 0) {
                    headV.title = hotCount ? @"最热评论" : @"最新评论";
                } else {
                    headV.title = @"最新评论";
                }
    
     return headV ;
}
- (void)moreBtuttonClick{
    
    UIAlertController * alertVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction * jubao = [UIAlertAction actionWithTitle:@"举报" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * shoucang=[UIAlertAction actionWithTitle:@"收藏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:shoucang];
    [alertVC addAction:jubao];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
