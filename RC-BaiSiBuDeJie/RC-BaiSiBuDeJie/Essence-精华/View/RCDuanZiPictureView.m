//
//  RCDuanZiPictureView.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/11.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCDuanZiPictureView.h"
#import "RCDuanziModel.h"
#import "RCProgressView.h"
#import "RCShowPictureViewController.h"
@interface RCDuanZiPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *see_bigBtn;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImgV;
/** 进度条控件 */
@property (weak, nonatomic) IBOutlet RCProgressView *progressView;

@end
@implementation RCDuanZiPictureView
+ (instancetype)pictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib{
    // 不自动布局拉伸
    self.autoresizingMask = UIViewAutoresizingNone ;
     // 添加点击放大的手势
    self.imageV.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImage)];
    [self.imageV addGestureRecognizer:tap];
}
- (void)showImage{
    RCShowPictureViewController * showVC =[[RCShowPictureViewController alloc]init];
    showVC.model=self.model;
    [[UIApplication sharedApplication].keyWindow .rootViewController presentViewController:showVC animated:YES completion:nil];
}
- (void)setModel:(RCDuanziModel *)model{
    _model=model;
   
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:model.pictureProgress animated:NO];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
       
        self.imageV.userInteractionEnabled=NO;
        
        // 显示progressView
        self.progressView.hidden = NO;
        // 计算进度值
        model.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:model.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        self.imageV.userInteractionEnabled=YES;
        // 不是大图不需要Draw直接返回
        if(model.bigPicture == NO) return ;
        
        
        
        // 图形图片上下文
        UIGraphicsBeginImageContextWithOptions(model.pictureF.size, YES, 0.0);
        // 将下载完的Image对象绘制到图形上下文
        CGFloat width = model.pictureF.size.width;
        CGFloat heigth = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, heigth)];
        // 获取图片
        self.imageV.image= UIGraphicsGetImageFromCurrentImageContext();
        // 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    // 判断是否是gif
    NSString * extension =[model.large_image pathExtension];
    self.gifImgV.hidden=![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否是大图  是否显示"点击查看全图"
    self.see_bigBtn .hidden = !model.bigPicture;
}


@end
