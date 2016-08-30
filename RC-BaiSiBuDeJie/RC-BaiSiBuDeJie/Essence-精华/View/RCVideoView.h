//
//  RCVideoView.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/15.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCDuanziModel ;

@interface RCVideoView : UIView
+ (instancetype)videoView;
/** 帖子数据 */
@property (nonatomic ,strong) RCDuanziModel * model;
@end
