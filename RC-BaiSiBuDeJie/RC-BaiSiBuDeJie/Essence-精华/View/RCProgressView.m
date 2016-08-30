//
//  RCProgressView.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/11.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCProgressView.h"

@implementation RCProgressView
- (void)awakeFromNib{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [super setProgress:progress animated:animated];
    NSString * text=[NSString stringWithFormat:@"%.0f%%",progress*100];
    self.progressLabel.text=[text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
@end
