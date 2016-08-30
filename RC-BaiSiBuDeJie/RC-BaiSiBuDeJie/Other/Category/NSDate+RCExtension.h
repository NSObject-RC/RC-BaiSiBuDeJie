//
//  NSDate+RCExtension.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/10.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RCExtension)
/**
 *  比较两个时间差值
 */
- (NSDateComponents*)deltaFrom :(NSDate *)from;
/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
@end
