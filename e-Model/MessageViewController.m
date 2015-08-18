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
#import "AFHTTPRequestOperationManager.h"
#import "DataModels.h"
#import "BaseInfoDataModels.h"
#import "UserID/UserIDDataModels.h"
#import "UIImageView+WebCache.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *array;
    NSMutableArray *_arr;
    NSMutableArray *_Arr;
    NSMutableArray *_Arr1;
    NSMutableArray *_Arr2;
    MessageTableViewCell *cell;
    UserIDBC *baseBc;
    
}
@property (nonatomic,strong)UserIDBC *userID;
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
    [self GETinformation];
    // Do any additional setup after loading the view from its nib.
    _Arr = [[NSMutableArray alloc]initWithCapacity:0];
    _arr = [[NSMutableArray alloc]initWithCapacity:0];
    NSLog(@"-------%@++++++------",array);
    
    
}
- (void)GETinformation
{
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://api.emwcn.com/user"];
    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager1 GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"-------  %@ -----------",operation.responseString);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSArray *array222 = [dict objectForKey:@"data"];
        //        NSLog(@"___++++%ld++++____",array222.count);
        for (NSArray *arr in array222) {
             array = [[NSMutableArray alloc]initWithCapacity:0];
            //            NSLog(@"____%@_++++++______",dict);
            //            EMWUser *user = [EMWUser parseUserWithDictionary:dict];
            [array addObject:arr];
            [_Arr addObject:array];
            NSLog(@"------%@=======",array);
            NSLog(@"+++++++%@+++++++",[array objectAtIndex:0]);
            AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
            NSString *url1 = [NSString stringWithFormat:@"http://api.emwcn.com/user/%@",[array objectAtIndex:0]];
            manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
            [manager2 GET:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 NSLog(@"-------  %@ 646656565",operation.responseString);
                 NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
                 
                 baseBc = [[UserIDBC alloc]initWithDictionary:dict1];
                 [_arr addObject:baseBc];
                 NSLog(@"_______%@_______",_arr);
                 NSLog(@"--==%@==---",baseBc.data.baseInfo.qQ);
                 NSLog(@"--++%lf==",baseBc.data.businessInfo.inPrice);
                 NSLog(@"-----------%@-------------",baseBc.data.baseInfo.nickName);
                 _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-49)];
                 _tableView.delegate = self;
                 _tableView.dataSource = self;
                 [_tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"messageCell"];
                 _tableView.rowHeight = 100;
                 [self.view addSubview:_tableView];
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"+++++++  %@+++++++++++",error);
             }];
       }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"+++++++  %@+++++++++++",error);
    }];

}
//获取系统时间
- (NSString *)getDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    if (cell!=nil) {
        [cell removeFromSuperview];
    }
    UserIDBC *Data = [_arr objectAtIndex:indexPath.row];
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:Data.data.baseInfo.avatar]];
    cell.headerImageView.clipsToBounds = YES;
    cell.headerImageView.layer.cornerRadius = 35;
    cell.userName.text = Data.data.baseInfo.nickName;
//    NSLog(@"---------");
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
