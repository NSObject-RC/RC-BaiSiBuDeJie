//
//  RCNavigationController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/3.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCNavigationController.h"

@interface RCNavigationController ()

@end

@implementation RCNavigationController
/**
 * 当第一次使用这个类的时候会调用一次
 */

+ (void)initialize{
    
    // 当导航栏用在XMGNavigationController中, appearance设置才会生效
    //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    // 给导航栏添加背景颜色
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if(self.childViewControllers.count){
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"返回" forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:(UIControlStateHighlighted)];
        btn.size=CGSizeMake(70, 30);
        // 设置内容左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 按钮的内容向左偏移10
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [btn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
        
        // 有需要的时候可以在push到另一个界面隐藏tabbar
        viewController.hidesBottomBarWhenPushed=YES;
        
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];

}
- (void)back
{
    [self popViewControllerAnimated:YES];
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
