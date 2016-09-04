//
//  RCAddTagViewController.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/9/2.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCAddTagViewController : UIViewController
/** 获取tags的block */
@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);

/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;
@end
