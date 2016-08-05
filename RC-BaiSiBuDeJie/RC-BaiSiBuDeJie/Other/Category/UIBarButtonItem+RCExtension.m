//
//  UIBarButtonItem+RCExtension.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/4.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "UIBarButtonItem+RCExtension.h"

@implementation UIBarButtonItem (RCExtension)
+(instancetype)itemWithImage:(NSString *)image higtImage:(NSString *)higtImag target:(id)target action:(SEL)action{
    
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage imageNamed:higtImag] forState:(UIControlStateHighlighted)];
    btn.size=btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return  [[self alloc]initWithCustomView:btn];
    
}
@end
