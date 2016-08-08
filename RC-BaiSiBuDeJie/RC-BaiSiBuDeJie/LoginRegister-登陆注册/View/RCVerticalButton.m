//
//  RCVerticalButton.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/8.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCVerticalButton.h"

@implementation RCVerticalButton
- (instancetype)initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
        [self setup];
    }
    return self;
}
- (void)setup{
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
}

- (void)awakeFromNib{
    [self setup];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    // 调整图片
    self.imageView.x=0;
    self.imageView.y=0;
    self.imageView.width=self.width;
    self.imageView.height=self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
