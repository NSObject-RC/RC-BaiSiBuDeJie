//
//  RCDuanziModel.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/9.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCDuanziModel.h"
#import "RCCommentModel.h"
#import "RCUserModel.h"
@interface RCDuanziModel () // 类扩展，增加属性、成员变量 等
// 自己实现一个带下划线的成员变量，在这里写是私有的，别人不可以调用
//{
//    CGFloat _cellHeight;
//}

@end
@implementation RCDuanziModel
 //自己实现一个带下划线的成员变量，三种写法  这里只能写成员变量，不可写属性
{
    CGFloat _cellHeight;
    //CGRect  _pictureF;
    
}
+(NSDictionary*)replacedKeyFromPropertyName{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt":@"top_cmt[0]"
             };
}
- (NSString*)create_time{
    // 创建时间 NSString ————> NSDate
    NSDateFormatter * fmt =[[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * create =[fmt dateFromString:_create_time];
    if(create.isThisYear){  // 今年
        if(create.isToday){  // 今天
            NSDateComponents * cmps =[[NSDate date] deltaFrom:create];
            if(cmps.hour >=1){ // 时间差大于等于1小时
               return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >=1){ // 时间差小于1小时大于1分钟
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{
                return  @"刚刚";
            }
            
        }else if (create.isToday){  // 昨天
            fmt.dateFormat=@"昨天 HH:mm:ss";
            return  [fmt stringFromDate:create];
        }else{                // 其他
            fmt.dateFormat=@"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        
    }else{ // 不是今年
        return [fmt stringFromDate:create];
    }
}
-(CGFloat)cellHeight{
    
    
    
    if(!_cellHeight){
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * RCCellMargin, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH =ceilf( [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height );
        // cell的高度
        // 文字部分的高度
        _cellHeight = RCCellTextY + textH + RCCellMargin;
       
        // 根据段子的类型来计算cell的高度
        if(self.type == RCDuanZiTypePicture){  // 为图片
            // 图片显示在cell上的宽
            CGFloat pictureW =maxSize.width;
            // 图片显示在cell上的高 （宽高比）
            CGFloat pictureH =pictureW * self.height / self.width;
            if(pictureH >= RCPictureMaxH){
                pictureH = pictureW;
                self.bigPicture=YES;
            }
             // 计算图片控件的frame
            CGFloat pictureX = RCCellMargin;
            CGFloat pictureY = RCCellTextY + textH + RCCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + RCCellMargin;
            
        } else if (self.type == RCDuanZiTypeVoice){ // 为声音
            
            CGFloat vioceX = RCCellMargin;
            CGFloat vioceY = RCCellTextY + textH + RCCellMargin;
            CGFloat vioceW =maxSize.width;
            CGFloat vioceH = vioceW * self.height / self.width;
            _vioceF=CGRectMake(vioceX, vioceY, vioceW, vioceH);
            _cellHeight += vioceH + RCCellMargin;
        }else if (self.type == RCDuanZiTypeVideo){ // 视频
            CGFloat videoX = RCCellMargin;
            CGFloat videoY = RCCellTextY + textH + RCCellMargin;
            CGFloat videoW = maxSize.width ;
            CGFloat videoH =videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + RCCellMargin;
            
        }
        // 如果有最热评论
       // RCCommentModel* cmt=[self .top_cmt firstObject];
        if(self.top_cmt){
            NSString * content =[NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
            CGFloat contentH =ceilf( [content boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil] .size.height );
            static CGFloat const CellHotCommentTiteH = 16;
            _cellHeight += CellHotCommentTiteH + contentH + RCCellMargin;
        }
        // 底部工具条的高度
        _cellHeight += RCCellButttomViewH + RCCellMargin;
    }
    
    return _cellHeight;

}
@end
