//
//  RCVideoView.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/15.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCVideoView.h"
#import "RCDuanziModel.h"
#import "RCShowPictureViewController.h"
@interface RCVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLaber;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@end
@implementation RCVideoView
+(instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
}
- (void)awakeFromNib{
    self.autoresizingMask=UIViewAutoresizingNone;
    [self.imageV  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideo)]];
}
- (void)showVideo{
    RCShowPictureViewController *showVideo = [[RCShowPictureViewController alloc] init];
    showVideo.model = self.model;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVideo animated:YES completion:nil];
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
    self.videotimeLaber.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
@end
