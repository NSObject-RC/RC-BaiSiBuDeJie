//
//  RCAddToolBarView.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/9/1.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCAddToolBarView.h"
#import "RCAddTagViewController.h"

@interface RCAddToolBarView ()
/**顶部的View*/
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 添加按钮 */
@property (weak, nonatomic) UIButton *addButton;
/** 存放所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;

@end
@implementation RCAddToolBarView
- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib{
    // 添加一个加号按钮
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    //    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    //    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = RCCellMargin;
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    
    // 默认就拥有2个标签
    [self createTagLabels:@[@"吐槽", @"糗事"]];

}
- (void)addButtonClick
{
    RCAddTagViewController * rcAdd =[[RCAddTagViewController alloc]init];
    __weak typeof (self) weakSelf = self;
    [rcAdd setTagsBlock:^(NSArray *tags) {
        [weakSelf  createTagLabels:tags];
    }];
    UIViewController * root =[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController * nav =(UINavigationController*)root.presentedViewController;
    [nav pushViewController:rcAdd animated:YES];
    
//    XMGAddTagViewController *vc = [[XMGAddTagViewController alloc] init];
//    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
//    [nav pushViewController:vc animated:YES];
    
    // a modal 出 b
    //    [a presentViewController:b animated:YES completion:nil];
    //    a.presentedViewController -> b
    //    b.presentingViewController -> a
}

/**
 * 创建标签
 */
- (void)createTagLabels:(NSArray *)tags{
    // 先移除之前数组中所有的标签
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    // 取出block中数组中的所有的字符放到label上
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = RCRGBColor(74, 139, 209, 1);;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = [UIFont systemFontOfSize:14];
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2 * 5;
        tagLabel.height = 25;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
        
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + 5;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) { // 标签显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 标签显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + 5;
            }
        }
    }
    RCLog(@"-------%f",self.topView.width);
    
    
    // 获取最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + 5;
    
    // 更新 添加按钮 的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    } else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + 5;
    }


}
@end
