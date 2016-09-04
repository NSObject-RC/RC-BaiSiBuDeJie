/** 按了删除键后的回调 *///
//  RCPubTextField.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/9/2.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPubTextField : UITextField
/** 按了删除键后的回调 */@property (nonatomic ,copy) void(^deleteBlock)() ;
@end
