//
//  RCDuanZiCell.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/9.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCDuanziModel ;
@interface RCDuanZiCell : UITableViewCell
/**  帖子数据*/
@property (nonatomic ,strong) RCDuanziModel * model;
+ (instancetype)cell;
/**更多按钮（收藏，举报）*/
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@end
