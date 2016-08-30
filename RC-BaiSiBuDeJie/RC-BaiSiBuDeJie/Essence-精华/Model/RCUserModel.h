//
//  RCUserModel.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/29.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCUserModel : NSObject
/**用户名*/
@property (nonatomic ,copy) NSString * username;
/**性别*/
@property (nonatomic ,copy) NSString * sex;
/**头像*/
@property (nonatomic ,copy) NSString * profile_image;
@end
