//
//  RCVoiceTableViewController.m
//  RC-BaiSiBuDeJie
//
//  Created by RongCheng on 16/8/9.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "RCVoiceTableViewController.h"

@interface RCVoiceTableViewController ()

@end

@implementation RCVoiceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor greenColor];
    RCLogFun;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
   
    cell.textLabel.text=@"CCCC";
    return cell;
}
@end
