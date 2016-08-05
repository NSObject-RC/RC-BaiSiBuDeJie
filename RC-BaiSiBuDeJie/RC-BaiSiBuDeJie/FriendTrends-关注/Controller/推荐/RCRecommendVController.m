//
//  RCRecommendVController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/5.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCRecommendVController.h"
#import "RCRecommendModel.h"
@interface RCRecommendVController ()
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray * categories;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@end

@implementation RCRecommendVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"推荐关注";
    self.view.backgroundColor=RCRGBColor(234, 234, 234, 1.0);
    // 显示指示器
    
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeClear)];
    [SVProgressHUD showWithStatus:@"正在加载"];

    
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
     [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         RCLog(@"-----%@",responseObject);
         self.categories =[RCRecommendModel mj_objectArrayWithKeyValuesArray:@"list"];
         [SVProgressHUD dismiss];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [SVProgressHUD dismiss];
         [SVProgressHUD showErrorWithStatus:@"加载失败"];
     }];
    
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
