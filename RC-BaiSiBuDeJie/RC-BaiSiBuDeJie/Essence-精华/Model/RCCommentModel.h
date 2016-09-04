//
//  RCCommentModel.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/29.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCUserModel;
@interface RCCommentModel : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/**音频文件路径*/
@property (nonatomic,copy)NSString * voiceuri;
/**音频文件时长*/
@property (nonatomic,assign)NSInteger voicetime;
/**评论文字内容*/
@property (nonatomic,copy)NSString * content;
/**被点赞数量*/
@property (nonatomic,assign)NSInteger like_count;
/**用户*/
@property (nonatomic,strong)RCUserModel * user;
@end
