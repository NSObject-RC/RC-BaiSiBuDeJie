//
//  RCDuanziModel.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/9.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCCommentModel.h"
@interface RCDuanziModel : NSObject
// 自己实现一个带下划线的成员变量，在这里写子类可以调用
//{
//    CGFloat _cellHeight;
//}
/** id */
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪加V */
@property (nonatomic,assign,getter=isSina_V)BOOL sina_v;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图片的URL */
@property (nonatomic, copy) NSString * small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString * middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString * large_image;
/** 帖子的类型 */
@property (nonatomic, assign) RCDuanZiType type;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/**最热评论（数组中存放的是RCCommentModel的模型）*/
@property (nonatomic ,strong) RCCommentModel * top_cmt;


/****** 额外的辅助属性 ******/

/** 直接返回cell的高*/
@property (nonatomic, assign,readonly) CGFloat cellHeight;
/** 直接返回中间图片的fram*/
@property (nonatomic ,assign,readonly) CGRect pictureF;
/** 图片是否超大图*/
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** 直接返回声音中间图片的fram*/
@property (nonatomic ,assign,readonly) CGRect vioceF;

/** 直接返回视频中间图片的fram*/
@property (nonatomic ,assign,readonly) CGRect videoF;
@end
