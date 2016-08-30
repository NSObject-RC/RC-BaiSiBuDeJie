//
//  RCCommentHeadView.h
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/30.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCCommentHeadView : UITableViewHeaderFooterView
@property (nonatomic ,copy) NSString * title;
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
