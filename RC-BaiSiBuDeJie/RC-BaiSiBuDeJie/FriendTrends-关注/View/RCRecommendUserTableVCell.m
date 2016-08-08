
//
//  RCRecommendUserTableVCell.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/5.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCRecommendUserTableVCell.h"
#import "RCRecommendUserModel.h"

@interface RCRecommendUserTableVCell ()
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *screen_name;
@property (weak, nonatomic) IBOutlet UILabel *fans_count;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;

@end

@implementation RCRecommendUserTableVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.header.layer.masksToBounds=YES;
    self.header.layer.cornerRadius=25;
}
- (void)setModel:(RCRecommendUserModel *)model{
    _model=model;
    self.screen_name.text=model.screen_name;
    self.fans_count.text=[NSString stringWithFormat:@"%zd人关注",model.fans_count];
    [self.header sd_setImageWithURL:[NSURL URLWithString:model.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] ];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
