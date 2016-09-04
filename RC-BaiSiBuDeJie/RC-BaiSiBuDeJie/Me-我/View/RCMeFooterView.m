//
//  RCMeFooterView.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/9/1.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCMeFooterView.h"
#import "RCMeSquareButton.h"
#import "RCSquareModel.h"
#import "RCMeWebViewController.h"
@implementation RCMeFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           // RCLog(@"-----%@",responseObject);
            
            NSArray *sqaures = [RCSquareModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
          //  RCLog(@"-----%zd",sqaures.count);
            
            // 创建方块
            [self createSquares:sqaures];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}
/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)sqaures
{
    // 一行最多4列
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = WIDTH / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<sqaures.count; i++) {
        // 创建按钮
        RCMeSquareButton *button = [RCMeSquareButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.squareModel = sqaures[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    // 8个方块, 每行显示4个, 计算行数 8/4 == 2 2
    // 9个方块, 每行显示4个, 计算行数 9/4 == 2 3
    // 7个方块, 每行显示4个, 计算行数 7/4 == 1 2
    
    // 总行数
    //    NSUInteger rows = sqaures.count / maxCols;
    //    if (sqaures.count % maxCols) { // 不能整除, + 1
    //        rows++;
    //    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
//    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
//    
//     //计算footer的高度
//    self.height = rows * buttonH ;
//    RCLog(@"---%f",self.height);
//    
//    // 重绘
//    [self setNeedsDisplay];
}
- (void)buttonClick:(RCMeSquareButton*)sender{
    if(![sender.squareModel.url hasPrefix:@"http"]) return;
    RCMeWebViewController * web=[[RCMeWebViewController alloc]init];
    web.url = sender.squareModel.url;
    web.title= sender.squareModel.name;
    
    // 取出当前控制器
    UITabBarController * tabBarVc=(UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController * nav =tabBarVc.selectedViewController;
    [nav pushViewController:web animated:YES];
}


@end
