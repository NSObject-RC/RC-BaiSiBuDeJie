//
//  RCAddTagViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/9/2.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCAddTagViewController.h"
#import "RCPubTagButton.h"
#import "RCPubTextField.h"
@interface RCAddTagViewController ()<UITextFieldDelegate>
/** 内容 */
@property (nonatomic, weak) UIView *contentView;
/** 文本输入框 */
@property (nonatomic, weak) RCPubTextField *textField;
/** 添加按钮 */
@property (nonatomic, weak) UIButton *addButton;
/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation RCAddTagViewController
- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
- (UIButton*)addButton{
    if(!_addButton){
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.width = self.contentView.width;
        btn.height = 35 ;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        [btn addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.backgroundColor=RCRGBColor(74, 139, 209, 1);
        [self.contentView addSubview:btn];
        _addButton = btn;
        
    }
    return  _addButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupContentView];
    [self setupTextFiled];
}
- (void)setupTextFiled{
    RCPubTextField * tf =[[RCPubTextField alloc]init];
    tf.delegate=self;
    tf.width=self.contentView.width;
    __weak typeof(self)weakSelf = self;
    tf.deleteBlock = ^{
        if(weakSelf.textField.hasText) return ;
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
    };
    //tf.height = 25;
   // tf.placeholder = @"多个标签用逗号或者换行隔开";
    // 设置了占位文字内容以后, 才能设置占位文字的颜色,在UITextField内部的label是懒加载的，必须先要有占位文字才可以设置
    //[tf setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    // 监听输入文字的变化（代理监听时输入键盘toolBar上的文字没有变化，所以不准）
    [tf addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:tf];
    self.textField = tf;
}
- (void)setupContentView{
    UIView * contentView=[[UIView alloc]init];
    contentView.x = 5;
    contentView.width = self.view.width - 2* 5;
    contentView.y = 64+5;
    contentView.height = HEIGTH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
}
- (void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title= @"添加标签";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:(UIBarButtonItemStyleDone) target:self action:@selector(doneClick)];
}

/**
 * 监听"添加标签"按钮点击
 */
- (void)addButtonClick{
    RCPubTagButton * tagBtn=[RCPubTagButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setTitle:self.textField.text forState:UIControlStateNormal];
    tagBtn.height = self.textField.height;
    [tagBtn addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagBtn];
    [self.tagButtons addObject:tagBtn];
    // 更新标签按钮的frame
    [self updateTagButtonFrame];

    
    // 清空textField文字
    self.textField.text =@"";
    self.addButton.hidden = YES;
}
/**
 * 标签按钮的点击
 */
- (void)tagButtonClick:(RCPubTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    // 重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
}

- (void)updateTagButtonFrame{
    // 更新标签按钮的frame
    for (int i =0; i<self.tagButtons.count;i++){
        RCPubTagButton * tagBtn = self.tagButtons[i];
        if(i==0){
            tagBtn.x=0;
            tagBtn.y=0;
        }
        else{
            // 上一个按钮
            RCPubTagButton *lastTagButton = self.tagButtons[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + 5;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if(rightWidth >= tagBtn.width){ // 按钮显示在当前行
                tagBtn.y = lastTagButton.y;
                tagBtn.x = leftWidth;
            }else{  // 按钮显示在下一行
                tagBtn.y = CGRectGetMaxY(lastTagButton.frame) + 5;
                tagBtn.x = 0;
            }
        }
    }
    
    // 最后一个标签按钮
    RCPubTagButton * lastTagBtn =[self.tagButtons lastObject];//最后一个按钮
    CGFloat leftWidth = CGRectGetMaxX(lastTagBtn.frame) + 5;
    // 更新textField的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagBtn.y;
        self.textField.x = leftWidth;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagBtn.frame) + 5;
    }
    
    // 更新“添加标签”的frame
    self.addButton.y = CGRectGetMaxY(self.textField.frame) + 5;
}
/**
 * textField的文字宽度
 */
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(30, textW);
}

/**
 * 监听文字改变
 */
- (void)textDidChange{
    if(self.textField.hasText){
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + RCCellMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        
        // 获得最后一个字符
        NSString * text =self.textField.text;
        NSInteger length = text.length;
        NSString * lastString =[text substringFromIndex:length-1];
        if(( [lastString isEqualToString:@","] ||[lastString isEqualToString:@"，"] )&& length>1){
            self.textField.text = [text substringToIndex:length - 1];
            [self addButtonClick];
        }

    }
    else{
        self.addButton.hidden = YES;
    }
    [self updateTagButtonFrame];
    
}
// 也能在这个方法中监听键盘的输入，比如输入“换行 \n” 在自定义的UITextField
//- (void)insertText:(NSString *)text
//{
//    [super insertText:text];
//
//    XMGLog(@"%d", [text isEqualToString:@"\n"]);
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}
- (void)doneClick{
   // 传递生数据给上一个控制器
//    NSMutableArray * tags =[NSMutableArray array];
//    for (RCPubTagButton * btn in self.tagButtons ){
//        [tags addObject:[btn currentTitle]];
//    }
    // 传递tags给这个block
    NSArray * tags =[self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? :self.tagsBlock(tags);
    [self .navigationController popViewControllerAnimated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
