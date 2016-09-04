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
#import "RCCommentCell.h"
static NSString * const RCCommentCellID = @"comment";

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
/**保存当前页码*/
@property (nonatomic,assign)NSInteger page;
/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation RCCommentViewController
- (AFHTTPSessionManager*)manager{
    if(!_manager){
        _manager=[AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupTableViewHeadView];
    [self setupRefresh];

}
- (void)setupRefresh{
    self.tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableV.mj_header beginRefreshing];
   
    
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableV.mj_footer.hidden = YES;
    
}

- (void)loadMoreComments{
    
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    // 页码
    NSInteger page =self.page +1;
    params[@"a"]=@"dataList";
    params[@"c"]=@"comment";
    params[@"data_id"] = self.model.ID;
    params[@"page"] = @(page);
    RCCommentModel * model=[self.latestComments lastObject];
    params[@"lastcid"] = model.ID;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        // 最新评论
        NSArray * newComments =[RCCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        // 请求成功了过后才加1
        self.page=page;
        [self.tableV reloadData];
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableV.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableV.mj_footer endRefreshing];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableV.mj_header endRefreshing];
    }];

}
// 加载新数据
- (void)loadNewComments{
    
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 参数
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    params[@"a"]=@"dataList";
    params[@"c"]=@"comment";
    params[@"data_id"] = self.model.ID;
    params[@"hot"]=@"1";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            
        }
        //最热评论
        self.hotComments=[RCCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        // 在这里请求成功了过后
        self.page= 1 ;
        
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
    
    // 取消所有任务
    //    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
}
- (void)setupTableView{
    self.navigationItem.title=@"评论";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" higtImage:@"comment_nav_item_share_icon_click" target:self action:@selector(moreBtuttonClick)];
    // cell的高度设置
    self.tableV.estimatedRowHeight = 44;//cell的估计高度
    self.tableV.rowHeight = UITableViewAutomaticDimension;//自己计算高度
    self.tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableV.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.tableV registerNib:[UINib nibWithNibName:NSStringFromClass([RCCommentCell class]) bundle:nil] forCellReuseIdentifier:RCCommentCellID];
    
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
     tableView.mj_footer.hidden = (latestCount == 0);
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
    RCCommentCell * cell=[tableView dequeueReusableCellWithIdentifier:RCCommentCellID];
    RCCommentModel*model =[self commentInIndexPath:indexPath];
    cell.commentModel= model;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RCCommentCell * cell =[tableView cellForRowAtIndexPath:indexPath];
    [cell  becomeFirstResponder];
    UIMenuController * menu=[UIMenuController sharedMenuController];
    if(menu.isMenuVisible){
        [menu setMenuVisible:NO animated:YES];
        return;
    }
    UIMenuItem * ding=[[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem * replay=[[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
    UIMenuItem * report=[[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
    menu.menuItems=@[ding,replay,report];
    
    CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
    [menu setTargetRect:rect inView:cell];
    [menu setMenuVisible:YES animated:YES];
    
    
}
#pragma mark - MenuItem处理
- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableV indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)replay:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableV indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableV indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
