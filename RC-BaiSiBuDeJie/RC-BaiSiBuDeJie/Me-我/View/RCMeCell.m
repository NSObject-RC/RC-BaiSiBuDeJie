//
//  RCMeCell.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/9/1.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCMeCell.h"

@implementation RCMeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        self.textLabel.textColor = [UIColor grayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if(self.imageView==nil) return;
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5 ;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + RCCellMargin;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
