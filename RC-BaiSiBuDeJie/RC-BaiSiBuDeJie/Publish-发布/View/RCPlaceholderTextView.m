//
//  RCPlaceholderTextView.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/9/1.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCPlaceholderTextView.h"
@interface RCPlaceholderTextView ()
/** 占位文字label */
@property (nonatomic,weak)UILabel *placeholderLabel;
@end
@implementation RCPlaceholderTextView
- (UILabel*)placeholderLabel{
    if(!_placeholderLabel){
        UILabel * label =[[UILabel alloc]init];
        label.numberOfLines=0;
        label.x=4;
        label.y=7;
        [self addSubview:label];
        _placeholderLabel = label;
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
    
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;

        self.font=[UIFont systemFontOfSize:16];
    
        self.placeholderColor = [UIColor grayColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)textDidChange{
    // 重新绘制执行drawRect:(CGRect)rect前会将之前绘制的图形清空
    // drawRect
    //[self setNeedsDisplay];
    
    
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//drawRect
//- (void)drawRect:(CGRect)rect {
//    // 如果有文字, 直接返回, 不绘制占位文字
//    //    if (self.text.length || self.attributedText.length) return;
//    if (self.hasText) return;
//    
//    rect.origin.x = 4;
//    rect.origin.y = 7;
//    rect.size.width -= 2 * rect.origin.x;
//    
//    NSMutableDictionary * attr =[NSMutableDictionary dictionary];
//    attr[NSFontAttributeName] = self.font;
//    attr[NSForegroundColorAttributeName] = self.placeholderColor;
//    [self.placeholder drawInRect:rect withAttributes:attr];
//}

//
/**
 * 更新占位文字的尺寸 label
 */
//- (void)updatePlaceholderLabelSize
//{
//    CGSize maxSize = CGSizeMake(WIDTH - 2 * self.placeholderLabel.x, MAXFLOAT);
//    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
//    
//    
//}
- (void)layoutSubviews{ // 使用label完善
    [super layoutSubviews];
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
    
}


#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor= placeholderColor;
    
    //drawRect
   // [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    //[self updatePlaceholderLabelSize];
   
    // 使用label完善
    [self setNeedsLayout];
    
    
    //drawRect
    // [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    //[self updatePlaceholderLabelSize];
    
    // 使用label完善
    [self setNeedsLayout];
    
    //drawRect
    // [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange];
    
    
    //drawRect
    // [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange];
    
    //drawRect
    // [self setNeedsDisplay];
}

@end
