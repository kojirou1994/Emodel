//
//  PersonViewController.m
//  e-Model
//
//  Created by 魏众 on 15/7/21.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    PersonViewController *personVC;
}
@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"我的主页";
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
- (void)gerTableView
{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
         return 8;
    }else{
        return 0;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }else{
        return 44;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0.5;
    }else{
        return 200;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    if (cell!=nil) {
        [cell removeFromSuperview];
    }else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageCell"];
    }
    if (indexPath.row == 0) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        imageView.backgroundColor = [UIColor redColor];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius =30;
        [cell addSubview:imageView];
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(80, 10, 100, 30)];
        label.text = @"王秀秀";
        [cell addSubview:label];
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, 70, 30)];
        label1.text = @"专业度:";
        label1.font = [UIFont systemFontOfSize:14];
        [cell addSubview:label1];
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(150, 40, 100, 30)];
        [cell addSubview:imageView1];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(self.view.frame.size.width-100, 25, 80, 30);
        [button setTitle:@"上传头像" forState:UIControlStateNormal];
        [cell addSubview:button];
    }else{
        switch (indexPath.row) {
            
            case 1:
            {
                cell.textLabel.text =@"基本资料";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 2:
            {
                cell.textLabel.text =@"档期管理";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 3:
            {
                cell.textLabel.text =@"作品管理";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 4:
            {
                cell.textLabel.text =@"模卡视频";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 5:
            {
                cell.textLabel.text =@"充值余额";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 6:
            {
                cell.textLabel.text =@"账号绑定";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 7:
            {
                cell.textLabel.text =@"设置";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
                break;

            default:
                break;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
