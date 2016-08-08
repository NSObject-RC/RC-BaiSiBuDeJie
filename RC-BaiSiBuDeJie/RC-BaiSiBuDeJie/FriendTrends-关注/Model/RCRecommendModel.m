//
//  RCRecommendModel.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/5.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCRecommendModel.h"

@implementation RCRecommendModel
- (NSMutableArray *) userArray{
    if(!_userArray){
        _userArray=[NSMutableArray array];
    }
    return _userArray;
}
@end
