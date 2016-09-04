//
//  RCCommentCell.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/30.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCCommentCell.h"
#import "RCCommentModel.h"
#import "RCUserModel.h"
@interface RCCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLaber;
@property (weak, nonatomic) IBOutlet UILabel *contentLaber;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end
@implementation RCCommentCell

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}
-(void)setCommentModel:(RCCommentModel *)commentModel{
    _commentModel=commentModel;
    

    [self.profileImg setHeadImage:commentModel.user.profile_image];
    
    self.sexImg.image=[commentModel.user.sex isEqualToString:RCUserModelSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] :[UIImage imageNamed:@"Profile_womanIcon"];
    self.nameLaber.text=commentModel.user.username;
    self.contentLaber.text=commentModel.content;
    self.likeCount.text=[NSString stringWithFormat:@"%zd", commentModel.like_count];
    if(commentModel.voiceuri.length){
        self.voiceButton.hidden=NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", commentModel.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden=YES;
    }
    
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
