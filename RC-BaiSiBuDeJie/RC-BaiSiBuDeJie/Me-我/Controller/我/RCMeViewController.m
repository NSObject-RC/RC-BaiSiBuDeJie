//
//  RCMeViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/4.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCMeViewController.h"
#import "RCMeCell.h"
#import "RCMeFooterView.h"
#import "RCMeSquareButton.h"
#import "RCSquareModel.h"
#import "RCSettingTableViewController.h"
@interface RCMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UIView * footerView;
@end
@implementation RCMeViewController
static NSString * const RCMeCellId = @"RCMeCellId";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
}
- (void)setupTableView{
    UITableView * tabV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGTH) style:(UITableViewStyleGrouped)];
    tabV.delegate=self;
    tabV.dataSource=self;
    [self.view addSubview:tabV];
    
    
    [tabV registerClass:[RCMeCell class] forCellReuseIdentifier:RCMeCellId];
    
    //  tabV.sectionHeaderHeight = 0;
    //  tabV.sectionFooterHeight = RCCellMargin;
    // 调整inset
    //tabV.contentInset = UIEdgeInsetsMake(RCCellMargin - 35, 0, 0, 0);
    
   
    RCMeFooterView * rcfootV=[[RCMeFooterView alloc]init];
    rcfootV.height = 850;
    tabV.tableFooterView = rcfootV;
}
- (void)setupNav{
    self.navigationItem.title=@"我的";
    UIBarButtonItem * settingBtn=[UIBarButtonItem itemWithImage:@"mine-setting-icon" higtImage:@"mine-setting-icon-click" target:self action:@selector(settingBtnClick)];
    UIBarButtonItem * moonBtn=[UIBarButtonItem itemWithImage:@"mine-moon-icon" higtImage:@"mine-moon-icon-click" target:self action:@selector(moonBtnClick)];
    self.navigationItem.rightBarButtonItems = @[settingBtn,moonBtn];
}
- (void)settingBtnClick
{
    
    RCSettingTableViewController * set=[[RCSettingTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:set animated:YES];
}
- (void)moonBtnClick{
    RCLogFun;
}
#pragma mark -----UITableViewDelegate----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCMeCell * cell=[tableView dequeueReusableCellWithIdentifier:RCMeCellId];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
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
