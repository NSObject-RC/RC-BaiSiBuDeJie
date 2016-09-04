//
//  RCMeWebViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/9/1.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCMeWebViewController.h"
#import "NJKWebViewProgress.h"
@interface RCMeWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
/** 进度代理对象 */
@property (nonatomic, strong) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation RCMeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress=[[NJKWebViewProgress alloc]init];
    self.webView.delegate=self.progress;
    __weak typeof (self)weakSelf = self;
    self.progress.progressBlock = ^(float progress){
      
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    
    self.progress.webViewProxyDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    //  self.webView.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (IBAction)refinshClick:(id)sender {
    [self.webView reload];
}

- (IBAction)goBackClick:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForwardClick:(id)sender {
    [self.webView goForward];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

@end
