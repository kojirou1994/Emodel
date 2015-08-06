//
//  MessageViewController.m
//  e-Model
//
//  Created by 魏众 on 15/7/21.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "ChatViewController.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation MessageViewController
//PUSH下一页的时候隐藏，返回
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"messageCell"];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    if (cell!=nil) {
        [cell removeFromSuperview];
    }
    cell.headerImageView.image = [UIImage imageNamed:@"456.png"];
    cell.headerImageView.clipsToBounds = YES;
    cell.headerImageView.layer.cornerRadius = 10;
    cell.userName.text = @"清风明月";
    cell.messageLabel.text = @"你好！！！！";
    cell.dataLabel.text = @"15:00";
    cell.dataLabel.textAlignment = NSTextAlignmentRight;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *cvc = [[ChatViewController alloc]init];
     self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cvc animated:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
