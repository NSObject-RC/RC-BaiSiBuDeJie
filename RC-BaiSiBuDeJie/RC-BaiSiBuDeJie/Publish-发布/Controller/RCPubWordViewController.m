//
//  RCPubWordViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/9/1.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCPubWordViewController.h"
#import "RCPlaceholderTextView.h"
#import "RCAddToolBarView.h"
@interface RCPubWordViewController ()<UITextViewDelegate>
/** 文本输入控件 */
@property (nonatomic, weak) RCPlaceholderTextView *textView;
/** 工具条 */
@property (nonatomic, weak) RCAddToolBarView *toolbar;
@end

@implementation RCPubWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupPlaceholderTextView];
    [self setupToolBar];
    
    
}
- (void)setupToolBar{
    RCAddToolBarView * toolBarV=[RCAddToolBarView viewFromXib];
    toolBarV.width=self.view.width;
    toolBarV.y = self.view .height - toolBarV.height;
    [self.view addSubview:toolBarV];
    self.toolbar = toolBarV;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)keyboardWillChangeFrame:(NSNotification*)noti{
    // 键盘最终的frame
    CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画时间
     CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - HEIGTH);
    }];
}
- (void)setupPlaceholderTextView{
    RCPlaceholderTextView * text =[[RCPlaceholderTextView alloc]initWithFrame:self.view.bounds];
    text.delegate=self;
    text.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:text];
    self.textView = text;
}
- (void)setupNav{
    self.title = @"发表文字";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 默认不能点击
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}
- (void)cancel{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)post{
    RCLogFun;
}
#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
