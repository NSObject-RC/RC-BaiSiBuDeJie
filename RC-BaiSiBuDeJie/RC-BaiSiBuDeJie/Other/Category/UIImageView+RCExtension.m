//
//  UIImageView+RCExtension.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/31.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "UIImageView+RCExtension.h"

@implementation UIImageView (RCExtension)
- (void)setHeadImage:(NSString *)url{
     UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] :placeholder;
    }];
}
@end
