//
//  RCRecommendVController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/5.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCRecommendVController.h"
#import "RCRecommendModel.h"
#import "RCRecommendUserModel.h"
#import "RCRecommendTableViewCell.h"
#import "RCRecommendUserTableVCell.h"

@interface RCRecommendVController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray * categories;
/** 右边的类别数据 */
@property (nonatomic, strong) NSArray * users;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary * params;
/** AFN请求管理者 */
@property (nonatomic ,strong) AFHTTPSessionManager * manager;
@end

@implementation RCRecommendVController

static NSString * const RCCategoryId = @"category";
static NSString * const RCUserId = @"User";

-(AFHTTPSessionManager*)manager{
    if(!_manager){
        _manager=[AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
    
}
/**
 * 控件的初始化
 */
- (void)setupTableView
{
    self.navigationItem.title=@"推荐关注";
    self.view.backgroundColor=RCRGBColor(234, 234, 234, 1.0);
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RCRecommendTableViewCell class]) bundle:nil] forCellReuseIdentifier:RCCategoryId];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RCRecommendUserTableVCell class]) bundle:nil] forCellReuseIdentifier:RCUserId];
    self.userTableView.rowHeight=70;

    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
}
/**
 * 加载左侧的类别数据
 */
- (void)loadCategories
{
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeClear)];
    [SVProgressHUD showWithStatus:@"正在加载"];
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        // RCLog(@"*-----%@",responseObject);
        self.categories =[RCRecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        // 默认选中首行
        [self .categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self .userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];

}

/**
 * 添加刷新控件
 */
- (void)setupRefresh
{
    
    self.userTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden=YES;
}
#pragma mark - 下拉刷新新数据
- (void)loadNewUsers{
    
    RCRecommendModel * model=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    model.currentPage = 1;
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(model.id);
    params[@"page"]=@(model.currentPage);
    self.params=params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       // RCLog(@"-------%@",responseObject);
        
        NSArray * array =[RCRecommendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 清空数据
        [model.userArray removeAllObjects];
        
        [model.userArray addObjectsFromArray:array];
        
        model.total=[responseObject[@"total"]  integerValue];
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新表
        [self.userTableView reloadData];
        [self.userTableView.mj_header endRefreshing];
        [self checkFootState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         if(self.params != params) return ;
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.userTableView.mj_header endRefreshing];
     }];

}
#pragma mark - 上拉加载更多数据
-(void)loadMoreUsers{
   
    RCRecommendModel * model=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    // 发送请求，加载数据
     NSMutableDictionary * params =[NSMutableDictionary dictionary];
     params[@"a"] = @"list";
     params[@"c"] = @"subscribe";
     params[@"category_id"] = @(model.id);
     params[@"page"]=@(++model.currentPage);
    self.params=params;
     [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if(self.params != params) return ;
         
        NSArray * array =[RCRecommendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [model.userArray addObjectsFromArray:array];
         // 不是最后一次请求
         if (self.params != params) return;
         // 刷新表
         [self.userTableView reloadData];
         RCLog(@"%zd    %zd",model.total,model.userArray.count);
         
         // 结束底部控件刷新
         [self checkFootState];
         
       
        
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if (self.params != params) return;
         
         // 提醒
         [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
         
         // 让底部控件结束刷新
         [self.userTableView.mj_footer endRefreshing];
      }];
 
    
}
#pragma mark - 判断foot状态
- (void)checkFootState{
    RCRecommendModel * model=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    self.userTableView.mj_footer.hidden=(model.userArray.count==0);
    if(model.userArray.count == model.total){ // 没有更多数据了
        [self.userTableView.mj_footer  endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:self.categoryTableView]){
        return  self.categories.count;
    }else{
        RCRecommendModel * model=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        [self checkFootState];
        return model.userArray.count;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //左边表
    if([tableView isEqual:self.categoryTableView]){
        RCRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RCCategoryId];
        
        cell.model = self.categories[indexPath.row];
        return cell;
    }
    // 右边表
    else{
        RCRecommendUserTableVCell *cell = [tableView dequeueReusableCellWithIdentifier:RCUserId];
        RCRecommendModel * model=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.model=model.userArray[indexPath.row];
        return cell;

    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.userTableView .mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    RCRecommendModel * model =self.categories[indexPath.row];
    
    if (model.userArray.count){   // 之前已经有数据
        // 显示之前的数据
        [self.userTableView reloadData];
    }else{     //没有数据请求数据
       // 刷新，马上显示当前类别的数据，不让用户看到上一个类别的数据
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header beginRefreshing];
        
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 停止请求
- (void)dealloc{
    [self.manager.operationQueue cancelAllOperations];
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
