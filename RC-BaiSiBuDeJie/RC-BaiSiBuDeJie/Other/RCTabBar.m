//
//  RCTabBar.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/3.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCTabBar.h"
#import "RCPublishViewController.h"
@interface RCTabBar ()
/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation RCTabBar
- (instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
      //设置背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}
- (void)publishClick{
    RCPublishViewController * publish =[[RCPublishViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow .rootViewController  presentViewController:publish animated:NO completion:nil];
}
- (void)layoutSubviews{
    [super layoutSubviews];
   
    // 标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    
    // 设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他的UITabBarButton
    
    CGFloat btnY = 0;
    CGFloat btnW= width/5;
    CGFloat btnH = height;
    
    NSInteger index=0;
    
    for(UIControl * btn in self.subviews){
        if(![btn isKindOfClass:[UIControl class]] || btn==self.publishButton) continue;
        
        CGFloat btnX =btnW * ((index>1) ?(index+1):index);
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        index ++ ;
        
        if(added ==NO){
        [btn addTarget:self action:@selector(tabbarSelect) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
    added = YES;
}
- (void)tabbarSelect{
    [[NSNotificationCenter defaultCenter] postNotificationName:RCTabBarDidSelectNotification object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
