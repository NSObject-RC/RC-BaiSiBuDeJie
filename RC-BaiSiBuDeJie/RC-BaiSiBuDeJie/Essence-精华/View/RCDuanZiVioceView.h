//
//  RCDuanZiVioceView.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/15.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCDuanziModel ;

@interface RCDuanZiVioceView : UIView
+ (instancetype)VioceView;
/** 帖子数据 */
@property (nonatomic ,strong) RCDuanziModel * model;
@end
