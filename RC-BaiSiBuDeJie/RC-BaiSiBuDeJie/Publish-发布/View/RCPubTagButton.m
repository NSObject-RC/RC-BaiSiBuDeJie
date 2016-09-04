//
//  RCPubTagButton.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/9/2.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCPubTagButton.h"

@implementation RCPubTagButton
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:(UIControlStateNormal)];
        [self setTitleColor:RCRGBColor(74, 139, 209, 1) forState:(UIControlStateNormal)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.layer.borderWidth = 1;
        self.layer.borderColor =RCRGBColor(74, 139, 209, 1).CGColor;
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x = 5;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;

}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * 5;
}

@end
