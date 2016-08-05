//
//  UIBarButtonItem+RCExtension.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/4.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RCExtension)
+ (instancetype) itemWithImage:(NSString *)image higtImage:(NSString *)higtImag target:(id)target action:(SEL)action;
@end
