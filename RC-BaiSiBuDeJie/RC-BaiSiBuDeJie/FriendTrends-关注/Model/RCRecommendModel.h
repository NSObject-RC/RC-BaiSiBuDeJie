//
//  RCRecommendModel.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/5.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCRecommendModel : NSObject
/** 总数*/
@property (nonatomic,assign)NSInteger count ;
/** id*/
@property (nonatomic,assign)NSInteger id ;
/** 名字*/
@property (nonatomic ,copy) NSString * name;
@end
