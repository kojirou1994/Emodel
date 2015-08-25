//
//  MyNoticeViewController.m
//  e-Model
//
//  Created by 魏众 on 15/8/7.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "MyNoticeViewController.h"
#import "AFHTTPRequestOperation.h"
@interface MyNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UITextField *label0;
    UITextField *label1;
    UITextField *label2;
    UITextField *label4;
    UITextField *label5;
    UITextField *label6;
    UITextField *label7;
    UITextField *label9;
    UITextField *label10;
    UITextField *label8;
    UITextView *label11;
}
@end

@implementation MyNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"人鱼大片儿拍摄";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+60)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 &&indexPath.row == 12) {
        return 150;
    }else if (indexPath.section == 0 &&indexPath.row == 11){
        return 100;
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text =@"状态";
                label0 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label0.font = [UIFont systemFontOfSize:14];
                label0.textAlignment = NSTextAlignmentRight;
                label0.text = @"报名中";
                label0.textColor = [UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0];
                [cell addSubview:label0];
            }
                break;
            case 1:
            {
                cell.textLabel.text =@"工作类型";
                label1 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label1.font = [UIFont systemFontOfSize:14];
                label1.textAlignment = NSTextAlignmentRight;
                label1.text = @"服装拍摄";
                label1.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label1];
            }
                break;
            case 2:
            {
                cell.textLabel.text =@"时间";
                label2 = [[UITextField alloc]initWithFrame:CGRectMake(160, 5, 200, 34)];
                label2.font = [UIFont systemFontOfSize:14];
                label2.textAlignment = NSTextAlignmentRight;
                label2.text = @"7月10日上午-7月15日下午";
                label2.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label2];
            }
                break;
            case 3:
            {
                cell.textLabel.text =@"地区";
                label4 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label4.font = [UIFont systemFontOfSize:14];
                label4.textAlignment = NSTextAlignmentRight;
                label4.text = @"杭州市区基地拍摄";
                label4.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label4];

            }
                break;
            case 4:
            {
                cell.textLabel.text =@"模特";
                label5 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label5.font = [UIFont systemFontOfSize:14];
                label5.textAlignment = NSTextAlignmentRight;
                label5.text = @"外籍女模 外籍男模";
                label5.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label5];
            }
                break;
            case 5:
            {
                cell.textLabel.text =@"人数";
                label6 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label6.font = [UIFont systemFontOfSize:14];
                label6.textAlignment = NSTextAlignmentRight;
                label6.text = @"各2人";
                label6.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label6];
            }
                break;
            case 6:
            {
                cell.textLabel.text =@"报酬";
                label7 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label7.font = [UIFont systemFontOfSize:14];
                label7.textAlignment = NSTextAlignmentRight;
                label7.text = @"800元/小时左右";
                label7.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label7];
            }
                break;
            case 7:
            {
                
                cell.textLabel.text = @"备注";
                label8 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label8.font = [UIFont systemFontOfSize:14];
                label8.textAlignment = NSTextAlignmentRight;
                label8.text = @"";
                label8.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label11];

            }
                break;
            case 8:
            {
                cell.textLabel.text = @"联系人";
                label9 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label9.font = [UIFont systemFontOfSize:14];
                label9.textAlignment = NSTextAlignmentRight;
                label9.text = @"";
                label9.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label9];
            }
                break;
            case 9:
            {
                
                cell.textLabel.text = @"联系电话";
                label10 = [[UITextField alloc]initWithFrame:CGRectMake(210, 5, 150, 34)];
                label10.font = [UIFont systemFontOfSize:14];
                label10.textAlignment = NSTextAlignmentRight;
                label10.text = @"";
                label10.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label10];

            }
                break;
            case 10:
            {
                cell.textLabel.text =@"其他要求";
            }
                break;
            case 11:
            {
                label11 = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, 365, 90)];
                label11.font = [UIFont systemFontOfSize:14];
                label11.textAlignment = NSTextAlignmentRight;
                label11.text = @"";
                label11.textColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.7f alpha:1.0];
                [cell addSubview:label11];
            }
                break;

            case 12:
            {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 85, 215, 30)];
                label.font = [UIFont systemFontOfSize:12];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = @"活动开始前2小时截止报名";
                [cell addSubview:label];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(80, 115, 215, 30);
                [button setTitle:@"立即预约" forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0]];
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:button];
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
//    @"orderDate";
//    NSString *const kOrderDataStyle = @"style";
//    NSString *const kOrderDataId = @"id";
//    NSString *const kOrderDataTimeBucket = @"timeBucket";
//    NSString *const kOrderDataNote = @"note";
//    NSString *const kOrderDataContact = @"contact";
//    NSString *const kOrderDataCreatedAt = @"created_at";
//    NSString *const kOrderDataMobile = @"mobile";
//    NSString *const kOrderDataProduct = @"product";
//    NSString *const kOrderDataIsAgree = @"isAgree";
//    NSString *const kOrderDataAddress = @"address";
//    NSString *const kOrderDataNum = @"num";
//    NSString *const kOrderDataModelId = @"modelId";
//    NSString *const kOrderDataIsComplete = @"isComplete";
//    NSString *const kOrderDataCompanyId = @"companyId";
//
    NSString *strURL = [NSString stringWithFormat:@"http://api.emwcn.com/order"];
    NSString *str = [NSString stringWithFormat:@"id=%@&mobile=%@&orderDate=%@&timeBucket=%@&product=%@&style=%@&num=%ld&address=%@&contact=%@&mobile=%ld&note=%@",label0.text,label1.text,label2.text,label4.text,label5.text,label6.text,[label7.text integerValue],label8.text,label9.text,[label10.text integerValue],label11.text];
    
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strURL];
    NSData *postData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObjecy){
        NSLog(@"-------  %@ *********",operation.responseString);
        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict1);
//        bif = [[businessinfoBIF alloc]initWithDictionary:dict1];
//        self.dayPriceTF.text = [NSString stringWithFormat:@"%f",bif.data.dayPrice];
//        self.inPriceTF.text = [NSString stringWithFormat:@"%f",bif.data.inPrice];
//        self.outPriceTF.text = [NSString stringWithFormat:@"%f",bif.data.outPrice];
        //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //        [userDefaults setInteger:[self.dayPriceTF.text integerValue] forKey:@"username"];
        //        [userDefaults setInteger:[self.introduction.text integerValue] forKey:@"password"];
        //        [userDefaults setInteger:[self.outPriceTF.text integerValue] forKey:@"autoLogin"];
        //        [userDefaults synchronize];
        
        //        self.startCountTF.text = [NSString stringWithFormat:@"%f",bif.data.startCount];
        //        self.underWearPrice.text = [NSString stringWithFormat:@"%f",bif.data.underwearPrice];
        
        //        bif = [[businessinfoBIF alloc]initWithDictionary:dict1];
        //        bif.data.dayPrice = [self.dayPriceTF.text integerValue];
        //        bif.data.inPrice = [self.inPriceTF.text integerValue];
        //        bif.data.outPrice = [self.outPriceTF.text integerValue];
        //        bif.data.startCount = [self.startCountTF.text integerValue];
        //        bif.data.underwearPrice = [self.underWearPrice.text integerValue];

        //        NSLog(@"%f",bif.data.outPrice);
        //        NSLog(@"%f",bif.data.startCount);
        //        NSLog(@"%f",bif.data.underwearPrice);
        //        NSLog(@"%@",bif);
        
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
