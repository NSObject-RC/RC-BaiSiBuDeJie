//
//  RCDuanZiPictureView.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/11.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCDuanziModel ;

@interface RCDuanZiPictureView : UIView
+ (instancetype)pictureView;
/** 帖子数据 */
@property (nonatomic ,strong) RCDuanziModel * model;
@end
