//
//  RCEssenceViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/4.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCEssenceViewController.h"

#import "RCDuanZiTableViewController.h"
@interface RCEssenceViewController ()<UIScrollViewDelegate>
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic,weak)UIButton * selertedBtn;
/** 底部的crollScrollView */
@property (nonatomic, weak) UIScrollView *contentScrollV;
@end

@implementation RCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"] ];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" higtImage:@"MainTagSubIconClick" target:self action:@selector(leftItemClick)];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
   
     [self setupChildVs];
     [self setupTitlesView];
     [self setupContentScrollView];
}
/**
 * 初始化子控制器
 */
- (void)setupChildVs
{
    

    
    RCDuanZiTableViewController *all = [[RCDuanZiTableViewController alloc] init];
    all.type = RCDuanZiTypeAll;
    [self addChildViewController:all];
    
    RCDuanZiTableViewController *video = [[RCDuanZiTableViewController alloc] init];
    video.type = RCDuanZiTypeVideo;

    [self addChildViewController:video];
    
    RCDuanZiTableViewController *voice = [[RCDuanZiTableViewController  alloc] init];
    voice.type = RCDuanZiTypeVoice;

    [self addChildViewController:voice];
    
    RCDuanZiTableViewController *picture = [[RCDuanZiTableViewController alloc] init];
    picture.type = RCDuanZiTypePicture;

    [self addChildViewController:picture];
    
    RCDuanZiTableViewController *duanzi = [[RCDuanZiTableViewController alloc] init];
    duanzi.type = RCDuanZiTypeDuanZi;
    [self addChildViewController:duanzi];
    
}

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView{
    // 标签栏整体View
    UIView * v=[[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 35)];
    v.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.9];
    v.tag=100;
   [self.view addSubview:v];
    self.titlesView=v;
    
    // 标签栏底部的红色指示器
    UIView * indicatorV =[[UIView alloc]init];
    indicatorV.height=2;
    indicatorV.y=v.height-indicatorV.height;
    indicatorV.backgroundColor=[UIColor redColor];
    indicatorV.tag=50;
    [v addSubview:indicatorV];
    self.indicatorView=indicatorV;
   // 内部的按钮
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    for (NSInteger i =0;i<titles.count;i++){
        UIButton * btn=[[UIButton alloc]init];
        btn.frame=CGRectMake(WIDTH/5*i, 0, WIDTH/5, 35);
        [btn setTitle:titles[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        btn.tag=i;
        [btn setTitleColor:[UIColor redColor] forState:(UIControlStateDisabled)];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        if(i==0){
            btn.enabled = NO;
            self.selertedBtn=btn;
            [btn.titleLabel sizeToFit];
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = btn.centerX;
        }
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [v addSubview:btn];
    }
    
}
- (void)titleBtnClick:(UIButton*)sender{
    
    self.selertedBtn.enabled = YES;
    sender.enabled = NO;
    self.selertedBtn = sender;
   
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width=sender.titleLabel.width;
        self.indicatorView.centerX=sender.centerX;
    }];
    // ScrollView 滚动
    CGPoint offset = self.contentScrollV.contentOffset;
    offset.x = sender.tag * WIDTH;
    [self.contentScrollV setContentOffset:offset animated:YES];
}

/**
 * 底部的scrollView
 */
- (void)setupContentScrollView{
 
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView * contentSV=[[UIScrollView alloc]init];
    contentSV.frame=CGRectMake(0, 0, WIDTH, HEIGTH);
    contentSV.delegate=self;
    contentSV.pagingEnabled=YES;
    contentSV.contentSize=CGSizeMake(contentSV.width * self.childViewControllers.count, 0);
    [self.view insertSubview:contentSV atIndex:0];
    self.contentScrollV=contentSV;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentSV];

}

- (void)leftItemClick{
    RCLogFun;
}
#pragma mark - <UIScrollViewDelegate>
// 结束滚动的动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    // 取出子控制器
    UITableViewController * tabVC =self.childViewControllers[index];
    tabVC.view.frame=CGRectMake(scrollView.contentOffset.x, 0, WIDTH, HEIGTH);
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    tabVC.tableView.contentInset=UIEdgeInsetsMake(top, 0, bottom, 0);// 设置滚动条的内边距
    tabVC.tableView.scrollIndicatorInsets = tabVC.tableView.contentInset;
    [scrollView addSubview:tabVC.view];
}
// 结束减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    [self titleBtnClick:(UIButton*)[self.titlesView viewWithTag:(scrollView.contentOffset.x / WIDTH)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
