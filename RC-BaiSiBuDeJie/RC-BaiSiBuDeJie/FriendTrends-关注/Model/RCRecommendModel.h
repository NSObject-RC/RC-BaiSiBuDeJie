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
/** 这个类别对应的用户数据*/
@property (nonatomic ,strong) NSMutableArray * userArray;

/** 用户总数*/
@property (nonatomic,assign)NSInteger total ;


/** 当前页码*/
@property (nonatomic,assign)NSInteger currentPage ;
@end
