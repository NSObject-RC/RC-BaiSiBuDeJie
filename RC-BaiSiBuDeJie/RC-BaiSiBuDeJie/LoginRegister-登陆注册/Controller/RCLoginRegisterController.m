//
//  RCLoginRegisterController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/8.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCLoginRegisterController.h"

@interface RCLoginRegisterController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgBg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeft;

@end

@implementation RCLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // xib有问题fuck
    [self.view insertSubview:self.imgBg atIndex:0];
}
- (IBAction)registerButton:(UIButton*)sender {
    
  
    [self.view endEditing:YES];
    if (self.loginLeft.constant == 0) { // 显示注册界面
        self.loginLeft.constant = - self.view.width;
         sender.selected = YES;
        //[sender setTitle:@"已有账号?" forState:UIControlStateNormal];
    } else { // 显示登录界面
        self.loginLeft.constant = 0;
        sender.selected = NO;
       // [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }

   [UIView animateWithDuration:0.25 animations:^{
       [self.view layoutIfNeeded];
   }];
}
- (IBAction)cacelButton:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 // 因为新建了一个Window，导致这个不起左右。在info.plist添加View controller-based status bar appearance 为NO，通过application.statusBarStyle = UIStatusBarStyleLightContent来设置颜色。或是单独在某个控制器中隐藏新建的Window，销毁控制器的时候再显示回来。
/**
 * 当前控制器对应的状态栏控件是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
