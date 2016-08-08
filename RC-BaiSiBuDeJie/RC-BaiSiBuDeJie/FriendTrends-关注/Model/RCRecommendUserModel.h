//
//  RCRecommendUserModel.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/5.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCRecommendUserModel : NSObject
/** 头像*/
@property (nonatomic,copy)NSString  * header ;
/** 粉丝数（关注人数）*/
@property (nonatomic,assign)NSInteger fans_count ;
/** 昵称*/
@property (nonatomic ,copy) NSString * screen_name;

@end
