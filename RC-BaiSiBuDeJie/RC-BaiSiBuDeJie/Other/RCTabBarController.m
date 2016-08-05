//
//  RCTabBarController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/3.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCTabBarController.h"
#import "RCNavigationController.h"
#import "RCEssenceViewController.h"
#import "RCNewViewController.h"
#import "RCFriendTViewController.h"
#import "RCMeViewController.h"
#import "RCTabBar.h"
@interface RCTabBarController ()

@end

@implementation RCTabBarController
// 会在第一次调用
+ (void)initialize{
    // 通过apperance 统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    
    
    NSMutableDictionary * attrs =[NSMutableDictionary dictionary];
   // attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary * selectedAttrs =[NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    
    UITabBarItem * item =[UITabBarItem appearance];
   //使用系统的字体大小
    //[item setTitleTextAttributes:attrs forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selectedAttrs forState:(UIControlStateSelected)];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self setChildVC:[[RCEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setChildVC:[[RCNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setChildVC:[[RCFriendTViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setChildVC:[[RCMeViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[RCTabBar alloc]init] forKey:@"tabBar"];
}
- (void)setChildVC:(UIViewController*)vc title:(NSString*)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:image];
    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImage];
    RCNavigationController * nav=[[RCNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
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
