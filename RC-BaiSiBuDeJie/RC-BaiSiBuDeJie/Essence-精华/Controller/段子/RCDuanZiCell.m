
//
//  RCDuanZiCell.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/9.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCDuanZiCell.h"
#import "RCDuanziModel.h"
#import "RCDuanZiPictureView.h"
#import "RCDuanZiVioceView.h"
#import "RCVideoView.h"
#import "RCCommentModel.h"
#import "RCUserModel.h"
@interface RCDuanZiCell ()
/** 头像*/
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 名字*/
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/** 创建时间*/
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLab;
/** 顶*/
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/** 踩*/
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/** 转发*/
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/** 评论*/
@property (weak, nonatomic) IBOutlet UIButton *commentBTn;
/** 新浪V*/
@property (weak, nonatomic) IBOutlet UIImageView *sina_v;
/** 开头的文字*/
@property (weak, nonatomic) IBOutlet UILabel *text_laber;
/** 图片帖子中间的图片 */
@property (nonatomic, weak) RCDuanZiPictureView * pictureV;
/** 声音帖子中间的图片 */
@property (nonatomic, weak) RCDuanZiVioceView * vioceV;
/** 视频帖子中间的图片 */
@property (nonatomic, weak) RCVideoView * videoV;

/** 最热评论整体的View*/
@property (weak, nonatomic) IBOutlet UIView * hotCmtView;
/** 最热评论内容*/
@property (weak, nonatomic) IBOutlet UILabel *hotCmtContentLaber;


@end
@implementation RCDuanZiCell
+ (instancetype)cell{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
- (RCDuanZiPictureView*)pictureV{
    if(!_pictureV){
        RCDuanZiPictureView * pictureView =[RCDuanZiPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureV = pictureView;
    }
    return  _pictureV;
}
- (RCDuanZiVioceView*)vioceV{
    if(!_vioceV){
        RCDuanZiVioceView * vioce =[RCDuanZiVioceView VioceView];
        [self.contentView addSubview:vioce];
        self.vioceV = vioce;
    }
    return _vioceV;
}
- (RCVideoView*)videoV{
    if(!_videoV){
        RCVideoView * video =[RCVideoView videoView];
        [self.contentView addSubview:video];
        self.videoV = video;
    }
    return _videoV;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView * img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundView=img;
    
}
- (void)setModel:(RCDuanziModel *)model{
    _model=model;
    
    
   
    [self.profileImageView setHeadImage:model.profile_image];
    
    self.sina_v.hidden= model.isSina_V;
    self.nameLab.text= model.name;
    self.creatTimeLab.text=model.create_time;
    self.text_laber.text=model.text;
       
    // 设置按钮文字
    [self setupButtonTitle:self.dingBtn count:model.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiBtn count:model.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareBtn count:model.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commentBTn count:model.comment placeholder:@"评论"];
    
    if(model.type == RCDuanZiTypePicture){ // 是图片
        self.pictureV.hidden=NO;
        self.vioceV.hidden=YES;
        self.videoV.hidden=YES;
        self.pictureV.model=model;
        self.pictureV.frame=model.pictureF;
        
    }else if (model.type ==RCDuanZiTypeVoice){ // 是声音
        self.vioceV.hidden=NO;
        self.pictureV.hidden=YES;
        self.videoV.hidden=YES;
        self.vioceV.model=model;
        self.vioceV.frame=model.vioceF;
        
    } else if (model.type ==RCDuanZiTypeVideo){ // 视频
        self.videoV.hidden=NO;
        self.pictureV.hidden=YES;
        self.vioceV.hidden=YES;
        self.videoV.model=model;
        self.videoV.frame=model.videoF;
        
    }else{                                   // 段子
        self.pictureV.hidden=YES;
        self.vioceV.hidden=YES;
        self.videoV.hidden=YES;
    }
    
    //处理最热的评论
   // RCCommentModel * cmt = [model.top_cmt firstObject];
    if(model.top_cmt){
        self.hotCmtView.hidden=NO;
        
        self.hotCmtContentLaber.text=[NSString stringWithFormat:@"%@ : %@",model.top_cmt.user.username,model.top_cmt.content];
    }else{
        self.hotCmtView.hidden=YES;
    }
    
    
}
// 数据超过10000，显示XX.万。
- (void)setupButtonTitle:(UIButton*)button count:(NSInteger)count placeholder:(NSString*)placeholder{
    
    if(count > 10000){
        placeholder=[NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if (count>0){
        placeholder=[NSString stringWithFormat:@"%zd",count];
    }
    
    [button setTitle:placeholder forState:(UIControlStateNormal)];
}
- (void)setFrame:(CGRect)frame{
   
    frame.origin.y += RCCellMargin ;
    //frame.size.height -= margin;
    frame.size.height = self.model.cellHeight - RCCellMargin;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
