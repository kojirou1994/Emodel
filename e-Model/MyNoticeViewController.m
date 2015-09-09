//
//  MyNoticeViewController.m
//  e-Model
//
//  Created by 魏众 on 15/8/7.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "MyNoticeViewController.h"
#import "AFHTTPRequestOperation.h"
#import "taskDataModels.h"
#import "tasktask.h"
#import "taskData.h"
#import "AFHTTPRequestOperationManager.h"
#import "taskIDBaseClass.h"
#import "taskIDData.h"
@interface MyNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
//    UITextField *label0;
//    UITextField *label1;
//    UITextField *label2;
//    UITextField *label4;
//    UITextField *label5;
//    UITextField *label6;
//    UITextField *label7;
//    UITextField *label9;
//    UITextField *label10;
//    UITextField *label8;
//    UITextView *label11;
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
//    tasktask *task;
    taskIDBaseClass *task;
    NSMutableArray *array;
    NSMutableArray *_arr;
    NSMutableArray *_Arr;

}

@end

@implementation MyNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",self.id);
    NSString *strURL = [NSString stringWithFormat:@"http://10.0.1.11/task/%@?title=%@&workType=%ld&workersCount=%ld&workTime=%@&deadLine=%@&price=%ld&modelDemand=%@&otherDemand=%@&address=%@&created_at=%@&updated_at=%@&id=%@&userId=%@&imgUrl=%@&isAllowed=%@&@participant=%@remainning=%@&useTypeId=%@",self.id,label0.text,[label1.text integerValue],[label2.text integerValue],label3.text,label4.text,[label5.text integerValue],label6.text,label8.text,label9.text,label12.text,label11.text,label17.text,label18.text,label16.text,label15.text,label14.text,label10.text,label13.text];
        NSString* str = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObjecy){
        NSLog(@"-------  %@ *********",operation.responseString);
        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict1);
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        task = [[taskIDBaseClass alloc]initWithDictionary:dict1];
       
    }
     
                                     failure:^(AFHTTPRequestOperation *operation,NSError *error){
                                         if (error.code != NSURLErrorTimedOut) {
                                             NSLog(@"error: %@", error);
                                         }
                                         
                                     }];
    [operation start];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 11;
    }else{
        return 0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0 &&indexPath.row == 8) {
        return 190;
    }else{
        return 44;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text =@"任务名称";
                label0 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label0.font = [UIFont systemFontOfSize:14];
                label0.textAlignment = NSTextAlignmentRight;
                label0.text = task.data.title;
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
                cell.textLabel.text =@"报名开始时间";
                label3 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label3.font = [UIFont systemFontOfSize:14];
                label3.textAlignment = NSTextAlignmentRight;
//                NSString* workTime = [[task.data objectAtIndex:indexPath.row]valueForKey:@"workTime"];
                label3.text = task.data.createdAt;
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
//                NSString *deadLine = [[task.data objectAtIndex:indexPath.row]valueForKey:@"deadLine"];
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
//                NSString *price = [[task.data objectAtIndex:indexPath.row]valueForKey:@"price"];
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
//                NSString *modelDemand = [[task.data objectAtIndex:indexPath.row]valueForKey:@"modelDemand"];
                label6.text = task.data.modelDemand;
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
//                NSString *other = [[task.data objectAtIndex:0]valueForKey:@"otherDemand"];
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
//                NSString *address = [[task.data objectAtIndex:0]valueForKey:@"address"];
                label9.text = task.data.address;
                label9.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label9];
                
            }
                break;
            case 10:
            {
                cell.textLabel.text =@"工作时间";
                label10 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label10.font = [UIFont systemFontOfSize:14];
                label10.textAlignment = NSTextAlignmentRight;
//                NSString *remain = [[task.data objectAtIndex:0]valueForKey:@"remaining"];
                label10.text = task.data.workTime;
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
//                NSString* update_at = [[task.data objectAtIndex:0]valueForKey:@"updated_at"];
//                label11.text = update_at;
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
//                NSString *creat_at = [[task.data objectAtIndex:0]valueForKey:@"created_at"];
//                label12.text = creat_at;
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
//                NSString *userTypeId = [[task.data objectAtIndex:0]valueForKey:@"userTypeId"];
//                label13.text = userTypeId;
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
//                NSString *paticipant = [[task.data objectAtIndex:0]valueForKey:@"participant"];
//                label14.text = paticipant;
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
- (void)buttonClick:(UIButton *)btn
{
    NSString *strURL = [NSString stringWithFormat:@"http://api.emwcn.com/order"];
    NSString *str = [NSString stringWithFormat:@"id=%@&mobile=%@&orderDate=%@&timeBucket=%@&product=%@&style=%@&num=%ld&address=%@&contact=%@&mobile=%ld&note=%@",label0.text,label1.text,label2.text,label4.text,label5.text,label6.text,[label7.text integerValue],label8.text,label9.text,[label10.text integerValue],label11.text];
    
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strURL];
    NSData *postData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObjecy){
        NSLog(@"-------  %@ *********",operation.responseString);
        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict1);
        
    }
     
                                     failure:^(AFHTTPRequestOperation *operation,NSError *error){
                                         if (error.code != NSURLErrorTimedOut) {
                                             NSLog(@"error: %@", error);
                                         }
                                         
                                     }];
    [operation start];

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
