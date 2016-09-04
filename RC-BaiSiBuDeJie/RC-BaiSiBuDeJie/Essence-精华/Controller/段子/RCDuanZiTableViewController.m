//
//  RCDuanZiTableViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/9.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

//[responseObject writeToFile:@"/Users/RC/Desktop/hehehe.plist" atomically:YES];


#import "RCDuanZiTableViewController.h"
#import "RCDuanziModel.h"
#import "RCDuanZiCell.h"
#import "RCCommentViewController.h"
#import "RCNewViewController.h"
@interface RCDuanZiTableViewController ()
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 当前页码 */
@property (nonatomic,assign)NSInteger page;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;

/** 上次选中的索引(或者控制器) */
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@end

@implementation RCDuanZiTableViewController

- (NSMutableArray *)topics{
    if(!_topics){
        _topics=[NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化控制器
    [self setupTableView];
    // 添加刷新控件
    [self setRefresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabbarSelect) name:RCTabBarDidSelectNotification object:nil];
    
}

- (void)tabbarSelect{
    if(self.lastSelectedIndex == self.tabBarController.selectedIndex && [self.view isShowingOnKeyWindow]){
        [self.tableView.mj_header beginRefreshing];
    }
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
static NSString * const  RCDuanZiCellId= @"DuanZi";
- (void)setupTableView{

    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RCDuanZiCell class]) bundle:nil] forCellReuseIdentifier:RCDuanZiCellId];
}
-(void)setRefresh{
    self.tableView .mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDuanzi)];
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDuanzi)];
    self.tableView.mj_header.automaticallyChangeAlpha=YES;
    [self.tableView .mj_header beginRefreshing];
}

#pragma mark - a参数
- (NSString *)a{
    return [self.parentViewController isKindOfClass:[ RCNewViewController class]] ? @"newlist" :@"list";
}
// 加载新数据
- (void)loadNewDuanzi{
    // 结束上啦
    [self.tableView.mj_footer endRefreshing];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);;
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        
        if(self.params != params) return ;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        self.topics =[RCDuanziModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView .mj_header endRefreshing];
        // 清空页码 (假如已经加载了4页，page=4，再下拉刷新后，当前页码为0，再上拉加载后，从page+ ，也就是第5页开始的。实际应该接着0页后面从第1页开始)
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView .mj_header endRefreshing];
        if(self.params != params) return ;
        [self.tableView.mj_header  endRefreshing];
    }];

}
// 加载更多数据
- (void)loadMoreDuanzi{
    // 结束下拉(用户下拉后网速不好，正在加载中，又上拉的时候，取消之前的下拉)
    [self.tableView.mj_header  endRefreshing];
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params=params;
    RCLog(@"---loadMoreDuanzi---%zd",page);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        
        if(self.params != params) return ;
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 字典 -> 模型
        NSArray * array =[RCDuanziModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:array];
        // 刷新表格
        [self.tableView reloadData];
         // 结束刷新
        [self.tableView .mj_footer endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView .mj_footer endRefreshing];
        if(self.params != params) return ;
        // 设置页码  请求失败时，页码减1（如加载第5页失败，则返回当前页码为第4页）
        self.page --;
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 没有数据的时候隐藏footer
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCDuanZiCell *cell = [tableView dequeueReusableCellWithIdentifier:RCDuanZiCellId forIndexPath:indexPath];
    RCDuanziModel *model = self.topics[indexPath.row];
    cell.model=model;
    cell.moreBtn.tag=indexPath.row;
    [cell.moreBtn addTarget:self action:@selector(moreBtuttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RCCommentViewController * commentVC=[[RCCommentViewController alloc]init];
    RCDuanziModel * model =self.topics[indexPath.row];
    commentVC.model=model;
    [self.navigationController pushViewController:commentVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RCDuanziModel *model = self.topics[indexPath.row];
    return model.cellHeight;
}
- (void)moreBtuttonClick:(UIButton*)sender{
  
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
@end
