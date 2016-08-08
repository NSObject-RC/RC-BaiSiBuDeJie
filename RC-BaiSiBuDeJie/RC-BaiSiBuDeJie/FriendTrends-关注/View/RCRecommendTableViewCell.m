//
//  RCRecommendTableViewCell.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/5.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCRecommendTableViewCell.h"
#import "RCRecommendModel.h"
@interface RCRecommendTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *selectedV;
 
@end
@implementation RCRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor=RCRGBColor(244, 244, 244, 244);
}
- (void)setModel:(RCRecommendModel *)model{
    _model = model;
    self.textLabel.text=model.name;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedV .hidden = !selected ;
    self.textLabel.textColor= selected ? [UIColor redColor] :RCRGBColor(78, 78, 78, 1.0);
    self.backgroundColor=selected ? [UIColor whiteColor] :RCRGBColor(244, 244, 244, 244);
}

@end
