//
//  UIImage+RCExtension.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/31.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "UIImage+RCExtension.h"

@implementation UIImage (RCExtension)
- (UIImage*)circleImage{
    
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage * img=UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭
    UIGraphicsEndImageContext();
    
    return img;
}
@end
