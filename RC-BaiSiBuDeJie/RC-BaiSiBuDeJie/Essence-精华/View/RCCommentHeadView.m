//
//  RCCommentHeadView.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/30.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCCommentHeadView.h"
@interface RCCommentHeadView()
@property (nonatomic,weak)UILabel * laber;
@end
@implementation RCCommentHeadView
+(instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString * ID = @"headView";
    RCCommentHeadView * headV=[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if(!headV){
        headV=[[RCCommentHeadView alloc]initWithReuseIdentifier:ID];
    }
    return headV;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self =[super initWithReuseIdentifier:reuseIdentifier]){
        self.contentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        UILabel * lab=[[UILabel alloc]init];
        lab.textColor=[UIColor redColor];
        lab.font=[UIFont systemFontOfSize:15];
        lab.width=200;
        lab.x=RCCellMargin;
        lab.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:lab];
        self.laber=lab;
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    _title=[title copy];
    self.laber.text=title;
}
@end
