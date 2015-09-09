//
//  NoticeDetailViewController.m
//  e-Model
//
//  Created by 魏众 on 15/8/5.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "NoticeDetailViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "OrderDataModels.h"
#import "AFHTTPRequestOperation.h"
#import "UserIDBC.h"
#import "taskDataModels.h"
@interface NoticeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_arr;
    NSMutableArray *_array;
    NSDictionary *_dict2;
    OrderOrderBC *bc;
    UITextField *cityId;
    UITextField *label0;
    UITextField *label1;
    UITextField *label2;
    UITextField *label3;
    UITextField *label4;
    UITextField *label5;
    UITextField *label6;
    UITextField *label7;
    UITextField *label9;
    UITextField *label10;
    UITextField *label11;
    UITextView *label8;
    UITextField *label12;
    UITextField *label13;
    UITextField *label14;
    UITextField *label15;
    UITextField *label16;
    UITextField *label17;
    UITextField *label18;
    taskInfotask *task;
}
@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self readNSUserDefaults];
    self.title = @"发布通告";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    _arr = [[NSMutableArray alloc]initWithCapacity:0];
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    NSString *strURL = [NSString stringWithFormat:@"http://10.0.1.11/user/55a7abd98a5da518db646c01/taskinfo?title=%@&workType=%ld&workersCount=%ld&workTime=%@&deadLine=%@&price=%ld&modelDemand=%@&otherDemand=%@&address=%@&created_at=%@&updated_at=%@&id=%@&userId=%@&imgUrl=%@&isAllowed=%@&@participant=%@remainning=%@&useTypeId=%@",label0.text,[label1.text integerValue],[label2.text integerValue],label3.text,label4.text,[label5.text integerValue],label6.text,label8.text,label9.text,label12.text,label11.text,label17.text,label18.text,label16.text,label15.text,label14.text,label10.text,label13.text];
    //      NSString *str = [NSString stringWithFormat:@"title=%@&workType=%ld&workersCount=%ld&workTime=%@&deadLine=%@&price=%ld&modelDemand=%@&otherDemand=%@&address=%@&created_at=%@&updated_at=%@&id=%@&userId=%@&imgUrl=%@&isAllowed=%@&@participant=%@remainning=%@&useTypeId=%@",label0.text,[label1.text integerValue],[label2.text integerValue],label3.text,label4.text,[label5.text integerValue],label6.text,label8.text,label9.text,label12.text,label11.text,label17.text,label18.text,label16.text,label15.text,label14.text,label10.text,label13.text];
    //    NSString *str = [NSString stringWithFormat:@"title=%@&workType=%ld&workersCount=%ld&workTime=%@&deadLine=%@&price=%ld&modelDemand=%@&otherDemand=%@",label0.text,[label1.text integerValue],[label2.text integerValue],label3.text,label4.text,[label5.text integerValue],label6.text,label8.text];
    NSLog(@"%@",label0.text);
    NSLog(@"%ld",[label1.text integerValue]);
    NSLog(@"%ld",[label2.text integerValue]);
    NSString* str = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:str];
    //    NSData *postData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [request setHTTPMethod:@"POST"];
    //    [request setHTTPBody:postData];
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObjecy){
        NSLog(@"-------  %@ *********",operation.responseString);
        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict1);
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        task = [[taskInfotask alloc]initWithDictionary:dict1];
    }
     
                                     failure:^(AFHTTPRequestOperation *operation,NSError *error){
                                         if (error.code != NSURLErrorTimedOut) {
                                             NSLog(@"error: %@", error);
                                         }
                                         
                                     }];
    [operation start];

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSString *url = [NSString stringWithFormat:@"http://api.emwcn.com/order"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSLog(@"-------  %@ 646656565",operation.responseString);
//        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
//         _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
//         _tableView.delegate = self;
//         _tableView.dataSource = self;
//         [self.view addSubview:_tableView];
//        OrderOrderBC* baseBc = [[OrderOrderBC alloc]initWithDictionary:dict1];
//         [_arr addObjectsFromArray:baseBc.data];
//         NSLog(@"--==%@==---",baseBc.data);
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"+++++++  %@+++++++++++",error);
//     }];
//    NSString *url1 =[NSString stringWithFormat:@"http://api.emwcn.com/user/55a7abd98a5da518db646c01/baseinfo"];
//    NSString *post = [NSString stringWithFormat:@"cityId = %@ ",cityId];
//    NSData *putData = [post dataUsingEncoding:NSUTF8StringEncoding];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url1]];
//    [request setHTTPMethod:@"PUT"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:putData];
//    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObjecy){
//        NSLog(@"-------  %@ *********",operation.responseString);
//               NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
//        UserIDBC *data = [[UserIDBC alloc]initWithDictionary:dict1];
//        [_array addObject:data];
//        _dict2 = [_array objectAtIndex:0];
//               NSLog(@"-------%@-------",_dict2);
//        NSLog(@"******%@*******",_array[0]);
//        NSString *information =@"操作成功";
//        NSNumber *resultCodeObj = [dict1 objectForKey:@"ResultCode"];
//        if ([resultCodeObj integerValue]<0) {
//           
//        }
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"操作成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil, nil];
//        [alert show];
//    }
//        failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        if (error.code != NSURLErrorTimedOut) {
//            NSLog(@"error: %@", error);
//        }
//            
//    }];
//    [operation start];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 19;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 &&indexPath.row == 8) {
        return 150;
    }else{
        return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text =@"任务名称";
                
//                cityId.font = [UIFont systemFontOfSize:14];
//                cityId.textAlignment = NSTextAlignmentRight;
//                NSDictionary *cityId1 = [_dict2 valueForKey:@"data"];
//                
//                cityId.text = [NSString stringWithFormat:@"%@",[cityId1 valueForKey:@"cityId"]];
//                NSLog(@"&&&%@&&&&",cityId.text);
//                cityId.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
//                [cell addSubview:cityId];
                label0 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label0.font = [UIFont systemFontOfSize:14];
                label0.textAlignment = NSTextAlignmentRight;
//                NSDictionary *cityId1 = [_dict2 valueForKey:@"data"];
//               
//                label0.text = [NSString stringWithFormat:@"%@",[cityId1 valueForKey:@"cityId"]];
//                 NSLog(@"&&&%@&&&&",label0.text);
                label0.text =task.data.title;
                label0.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label0];
            }
                break;
            case 1:
            {
                cell.textLabel.text =@"任务类型";
                label1 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label1.font = [UIFont systemFontOfSize:14];
                label1.textAlignment = NSTextAlignmentRight;
                label1.text = task.data.workType;
                label1.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label1];
                
            }
                break;
            case 2:
            {
                cell.textLabel.text =@"需要人数";
                label2 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label2.font = [UIFont systemFontOfSize:14];
                label2.textAlignment = NSTextAlignmentRight;
                label2.text = [NSString stringWithFormat:@"%lf",task.data.workersCount];
                label2.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label2];
            }
                break;
            case 3:
            {
                cell.textLabel.text =@"任务时间";
                label3 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label3.font = [UIFont systemFontOfSize:14];
                label3.textAlignment = NSTextAlignmentRight;
                label3.text = task.data.workTime;
                label3.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label3];
            }
                break;
            case 4:
            {
                cell.textLabel.text =@"报名截止时间";
               label4 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label4.font = [UIFont systemFontOfSize:14];
                label4.textAlignment = NSTextAlignmentRight;
                label4.text = task.data.deadLine;
                label4.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label4];
            }
                break;
            case 5:
            {
                cell.textLabel.text =@"报价";
                label5 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label5.font = [UIFont systemFontOfSize:14];
                label5.textAlignment = NSTextAlignmentRight;
                label5.text = task.data.price;
                label5.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label5];
            }
                break;
            case 6:
            {
                cell.textLabel.text =@"模特要求";
                label6 = [[UITextField alloc]initWithFrame:CGRectMake(160, 5, 200, 34)];
                label6.font = [UIFont systemFontOfSize:14];
                label6.textAlignment = NSTextAlignmentRight;
                label6.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                label16.text = task.data.modelDemand;
//                NSDictionary *dict = [_arr objectAtIndex:0];
//                label6.text = [NSString stringWithFormat:@"%@", [dict valueForKey:@"num"]];
//                label6.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label6];
            }
                break;
            case 7:
            {
                cell.textLabel.text =@"其他要求";
            }
                break;
            case 8:
            {
                label8 = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, 365, 140)];
                label8.font = [UIFont systemFontOfSize:14];
                label8.textAlignment = NSTextAlignmentRight;
                label8.text = task.data.otherDemand;
                label8.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label8];

            }
                break;
            case 9:
            {
                cell.textLabel.text =@"地点";
                label9 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label9.font = [UIFont systemFontOfSize:14];
                label9.textAlignment = NSTextAlignmentRight;
                label9.text = task.data.address;
                label9.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label9];

            }
                break;
            case 10:
            {
                cell.textLabel.text =@"剩余时间";
                label10 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label10.font = [UIFont systemFontOfSize:14];
                label10.textAlignment = NSTextAlignmentRight;
                label10.text =task.data.remaining;
                label10.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label10];
            }
                break;
            case 11:
            {
                cell.textLabel.text =@"更新日期";
                label11 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label11.font = [UIFont systemFontOfSize:14];
                label11.textAlignment = NSTextAlignmentRight;
                label11.text = task.data.updatedAt;
                label11.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label11];
                
            }
                break;
            case 12:
            {
                cell.textLabel.text =@"创建日期";
                label12 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label12.font = [UIFont systemFontOfSize:14];
                label12.textAlignment = NSTextAlignmentRight;
                label12.text = task.data.createdAt;
                label12.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label12];
            }
                break;
            case 13:
            {
                cell.textLabel.text =@"用户类型";
                label13 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label13.font = [UIFont systemFontOfSize:14];
                label13.textAlignment = NSTextAlignmentRight;
                label13.text = task.data.userTypeId;
                label13.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label13];
            }
                break;
            case 14:
            {
                cell.textLabel.text =@"参与者";
                label14 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label14.font = [UIFont systemFontOfSize:14];
                label14.textAlignment = NSTextAlignmentRight;
                label14.text = task.data.participant;
                label14.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label14];
            }
                break;
            case 15:
            {
                cell.textLabel.text =@"是否允许";
                label15 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label15.font = [UIFont systemFontOfSize:14];
                label15.textAlignment = NSTextAlignmentRight;
                label15.text = task.data.isAllowed;
                label15.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label15];
            }
                break;
            case 16:
            {
                cell.textLabel.text =@"硬照";
                label16 = [[UITextField alloc]initWithFrame:CGRectMake(160, 5, 200, 34)];
                label16.font = [UIFont systemFontOfSize:14];
                label16.textAlignment = NSTextAlignmentRight;
                label16.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                label16.text = task.data.imgUri;
                //                NSDictionary *dict = [_arr objectAtIndex:0];
                //                label6.text = [NSString stringWithFormat:@"%@", [dict valueForKey:@"num"]];
                //                label6.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label16];
            }
                break;
            case 17:
            {
                cell.textLabel.text =@"ID";
                label17 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label17.font = [UIFont systemFontOfSize:14];
                label17.textAlignment = NSTextAlignmentRight;
                label17.text = @"";
                label17.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label17];

            }
                break;
            case 18:
            {
                cell.textLabel.text = @"用户ID";
                label18 = [[UITextField alloc]initWithFrame:CGRectMake(160, 5, 200, 34)];
                label18.font = [UIFont systemFontOfSize:14];
                label18.textAlignment = NSTextAlignmentRight;
                label18.text = task.data.userId;
                label18.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label18];
                
            }
                break;
               
            default:
                break;
        }

    }
        return cell;
}
- (void)rightItemClick
{
    NSLog(@"2222222");
       NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:label0.text forKey:@"title"];
    [userDefaults setInteger:[label1.text integerValue] forKey:@"workType"];
    [userDefaults setInteger:[label6.text integerValue] forKey:@"workersCount"];
    [userDefaults synchronize];

}

- (void)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *title = [userDefaultes stringForKey:@"title"];
    label0.text = title;
    NSInteger workTpye = [userDefaultes integerForKey:@"workTpye"];
    label1.text = [NSString stringWithFormat:@"%ld", workTpye];
    NSInteger workersCount = [userDefaultes integerForKey:@"workersCount"];
    label6.text = [NSString stringWithFormat:@"%ld",workersCount];
    //    NSInteger Username = [userDefaultes integerForKey:@"username"];
    //    self.underWearPrice.text = [NSString stringWithFormat:@"%ld",Username];
    //    NSInteger password = [userDefaultes integerForKey:@"parssword"];
    //    self.introduction.text = [NSString stringWithFormat:@"%ld",password];
    //    NSInteger autoLogin = [userDefaultes integerForKey:@"autoLogin"];
    //    self.mobileTF.text = [NSString stringWithFormat:@"%ld",autoLogin];
    
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
