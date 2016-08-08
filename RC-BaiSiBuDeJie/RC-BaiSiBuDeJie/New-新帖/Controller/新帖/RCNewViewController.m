//
//  RCNewViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/4.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCNewViewController.h"

@interface RCNewViewController ()

@end

@implementation RCNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"MainTagSubIcon" higtImage:@"MainTagSubIconClick" target:self action:@selector(leftItemClick)];
}
- (void)leftItemClick{
    RCLogFun;
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
