//
//  RCDuanZiVioceView.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/15.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCDuanZiVioceView.h"
#import "RCDuanziModel.h"

#import "RCShowPictureViewController.h"
@interface RCDuanZiVioceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLaber;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@end
@implementation RCDuanZiVioceView
+ (instancetype)VioceView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil ] lastObject];
}
- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    [self.imageV  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVioce)]];
}
- (void)showVioce{
    RCShowPictureViewController *showVioce = [[RCShowPictureViewController alloc] init];
    showVioce.model = self.model;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVioce animated:YES completion:nil];
}
- (void)setModel:(RCDuanziModel *)model{
    _model=model;
    // 图片
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.large_image] ];
    // 播放次数
    self.playcountLabel.text=[NSString stringWithFormat:@"%zd播放",model.playcount];
    // 时长
    NSInteger minute = model.videotime / 60;
    NSInteger second = model.voicetime % 60;
    self.voicetimeLaber.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
