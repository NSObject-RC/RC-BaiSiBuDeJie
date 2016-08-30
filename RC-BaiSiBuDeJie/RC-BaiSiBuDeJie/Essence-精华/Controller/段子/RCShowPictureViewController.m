
//
//  RCShowPictureViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/11.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCShowPictureViewController.h"
#import "RCDuanziModel.h"
#import "RCProgressView.h"
@interface RCShowPictureViewController ()
@property (weak,nonatomic)UIImageView * imageV;
@property (weak, nonatomic) IBOutlet UIScrollView *showScrollView;
@property (weak, nonatomic) IBOutlet RCProgressView *progressView;
@end

@implementation RCShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * img=[[UIImageView alloc]init];
    img.userInteractionEnabled=YES;
    
    [img addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backVC)]];
    [self.showScrollView  addSubview:img];
    self.imageV=img;
    
    // 图片frame
    CGFloat pictureW = WIDTH;
    CGFloat pictureH = pictureW * self.model.height / self.model.width;
    if(pictureH > HEIGTH){  // 超过屏幕
        img.frame=CGRectMake(0, 0, pictureW, pictureH);
        self.showScrollView.contentSize=CGSizeMake(0, pictureH);
    }else{   // 不超过屏幕
        img.bounds=CGRectMake(0, 0, pictureW, pictureH);
        img.center=CGPointMake(WIDTH/2, HEIGTH/2);
    }
   
    // 保证图片下载的进度与show的时候是一样的
    [self.progressView setProgress:self.model.pictureProgress animated:NO];
    
    [img sd_setImageWithURL:[NSURL URLWithString:self.model.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0*receivedSize / expectedSize animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden=YES;
    }];
    
}
- (IBAction)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)savePicture:(id)sender {
   
    // 图片没有下载完毕
    if(self.imageV.image == nil){
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕"];
        return;
    }
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageV.image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
}
// 保存后默认回调的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(error){
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
