//
//  RCFriendTViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/4.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCFriendTViewController.h"
#import "RCRecommendVController.h"
@interface RCFriendTViewController ()

@end

@implementation RCFriendTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的关注";
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"friendsRecommentIcon" higtImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecommentclick)];
    self.view.backgroundColor=RCRGBColor(234, 234, 234, 1);
}
- (void)friendsRecommentclick{
    
    [self.navigationController pushViewController:[[RCRecommendVController alloc]init] animated:YES];
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
