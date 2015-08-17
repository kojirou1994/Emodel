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
@interface NoticeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_arr;
    NSMutableArray *_array;
    NSDictionary *_dict2;
    OrderOrderBC *bc;
    UITextField *cityId;
}
@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发布通告";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    _arr = [[NSMutableArray alloc]initWithCapacity:0];
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://api.emwcn.com/order"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"-------  %@ 646656565",operation.responseString);
        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
         _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
         _tableView.delegate = self;
         _tableView.dataSource = self;
         [self.view addSubview:_tableView];
        OrderOrderBC* baseBc = [[OrderOrderBC alloc]initWithDictionary:dict1];
         [_arr addObjectsFromArray:baseBc.data];
         NSLog(@"--==%@==---",baseBc.data);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"+++++++  %@+++++++++++",error);
     }];
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
- (void)rightItemClick
{
    NSLog(@"2222222");
    //    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
//    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    [manager1 PUT:url1 parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
//        NSLog(@"-------  %@ *********",operation.responseString);
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"******%@******",dict);
//        //        OrderOrderBC* baseBc = [[OrderOrderBC alloc]initWithDictionary:dict];
//        //        [_arr addObjectsFromArray:baseBc.data];
//        //        NSLog(@"--==%@==---",baseBc.data);
//    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        NSLog(@"+++++++  %@+++++++++++",error);
//    }];
    
   }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 &&indexPath.row == 9) {
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
                cell.textLabel.text =@"标题";
                
//                cityId.font = [UIFont systemFontOfSize:14];
//                cityId.textAlignment = NSTextAlignmentRight;
//                NSDictionary *cityId1 = [_dict2 valueForKey:@"data"];
//                
//                cityId.text = [NSString stringWithFormat:@"%@",[cityId1 valueForKey:@"cityId"]];
//                NSLog(@"&&&%@&&&&",cityId.text);
//                cityId.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
//                [cell addSubview:cityId];
               UILabel* label0 = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label0.font = [UIFont systemFontOfSize:14];
                label0.textAlignment = NSTextAlignmentRight;
//                NSDictionary *cityId1 = [_dict2 valueForKey:@"data"];
//               
//                label0.text = [NSString stringWithFormat:@"%@",[cityId1 valueForKey:@"cityId"]];
//                 NSLog(@"&&&%@&&&&",label0.text);
                label0.text =@"人鱼大片儿拍摄";
                label0.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label0];
            }
                break;
            case 1:
            {
                cell.textLabel.text =@"工作";
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label1.font = [UIFont systemFontOfSize:14];
                label1.textAlignment = NSTextAlignmentRight;
                label1.text = @"服装拍摄";
                label1.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label1];
                
            }
                break;
            case 2:
            {
                cell.textLabel.text =@"开始";
                UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label2.font = [UIFont systemFontOfSize:14];
                label2.textAlignment = NSTextAlignmentRight;
                label2.text = @"7月10日上午";
                label2.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label2];
            }
                break;
            case 3:
            {
                cell.textLabel.text =@"结束";
                UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label3.font = [UIFont systemFontOfSize:14];
                label3.textAlignment = NSTextAlignmentRight;
                label3.text = @"7月15日下午";
                label3.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label3];
            }
                break;
            case 4:
            {
                cell.textLabel.text =@"地点";
                UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label4.font = [UIFont systemFontOfSize:14];
                label4.textAlignment = NSTextAlignmentRight;
                label4.text = @"杭州市区基地拍摄";
                label4.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label4];
            }
                break;
            case 5:
            {
                cell.textLabel.text =@"模特";
                UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label5.font = [UIFont systemFontOfSize:14];
                label5.textAlignment = NSTextAlignmentRight;
                label5.text = @"外籍女模 外籍男模";
                label5.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label5];
            }
                break;
            case 6:
            {
                cell.textLabel.text =@"人数";
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label.font = [UIFont systemFontOfSize:14];
                label.textAlignment = NSTextAlignmentRight;
                NSDictionary *dict = [_arr objectAtIndex:0];
                label.text = [NSString stringWithFormat:@"%@", [dict valueForKey:@"num"]];
                label.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label];
            }
                break;
            case 7:
            {
                cell.textLabel.text =@"报酬";
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label.font = [UIFont systemFontOfSize:14];
                label.textAlignment = NSTextAlignmentRight;
                label.text = @"800元/小时左右";
                label.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label];
            }
                break;
            case 8:
            {
                cell.textLabel.text =@"其他要求";
            }
                break;
            case 9:
            {
                UITextView *label = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, 365, 140)];
                label.font = [UIFont systemFontOfSize:14];
                label.textAlignment = NSTextAlignmentRight;
                label.text = @"";
                label.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label];
            }
                break;
                
            default:
                break;
        }

    }
        return cell;
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
