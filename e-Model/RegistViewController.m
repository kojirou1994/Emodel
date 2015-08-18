//
//  RegistViewController.m
//  e-Model
//
//  Created by 魏众 on 15/7/20.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "RegistViewController.h"
#import "MainViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "EMWUser.h"
#import "EMWHttpManager.h"
#define SHOW_ALERT(msg) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alert show];
@interface RegistViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *_data;
}
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"会员注册";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)sureButton:(UIButton *)sender {
    if (_phoneNumber.text.length<=0) {
        SHOW_ALERT(@"手机号码不能为空");
        return;
    }
    if (_pws.text.length<=0) {
        SHOW_ALERT(@"密码不能为空");
        return;
    }
    if (![_surePassWord.text isEqualToString:_pws.text]) {
        SHOW_ALERT(@"两次密码不一致");
        return;
    }
    NSString *strURL2 = [NSString stringWithFormat:@"http://api.emwcn.com/user/signup"];
    NSString *post2 =  [NSString stringWithFormat:@"mobile=%@&password=%@&confirm_token=%@&confirm=%@",self.phoneNumber.text,self.pws.text,self.phoneIdentifying.text,self.surePassWord.text];
    //    strURL1 = [strURL1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url2 = [NSURL URLWithString:strURL2];
    NSData *postData2 = [post2 dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:url2];
    [request2 setHTTPMethod:@"POST"];
    [request2 setHTTPBody:postData2];
    AFHTTPRequestOperation* operation2 = [[AFHTTPRequestOperation alloc]initWithRequest:request2];
    [operation2 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation2,id responseObjecy){
        NSLog(@"-------  %@ *********",operation2.responseString);
        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation2.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict1);
        
    }
                                      failure:^(AFHTTPRequestOperation *operation,NSError *error){
                                          if (error.code != NSURLErrorTimedOut) {
                                              NSLog(@"error: %@", error);
                                          }
                                          
                                      }];
    
    [operation2 start];
}
- (IBAction)confirm_tockenBtn:(UIButton *)sender
{
    [RegistViewController isValidateTelNumber:_phoneNumber.text];
    [self isMobileNumber:_phoneNumber.text];
    NSString *post = [NSString stringWithFormat:@"mobile=%@",self.phoneNumber.text];
    NSString *strURL = @"http://api.emwcn.com/user/confirm";
    NSURL *url = [NSURL URLWithString:strURL];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        _data = [NSMutableData new];
    }
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"请求完成");
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",dict);
    NSString *message;
    NSNumber *resultCodeObj = [dict objectForKey:@"status"];
    if ([resultCodeObj integerValue]==200) {
        message = @"操作成功";
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示信息" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    
    
}

//是否是有效的正则表达式

+(BOOL)isValidateRegularExpression:(NSString *)strDestination byExpression:(NSString *)strExpression{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    
    return [predicate evaluateWithObject:strDestination];
}

//验证email
+(BOOL)isValidateEmail:(NSString *)email {
    //jfkjkfj  @  ddvv  . com
    NSString *strRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}";
    BOOL rt = [self isValidateRegularExpression:email byExpression:strRegex];
    
    return rt;
}

//验证11位号码
+(BOOL)isValidateTelNumber:(NSString *)number {
    
    NSString *strRegex = @"[0-9]{11,11}";
    
    BOOL rt = [self isValidateRegularExpression:number byExpression:strRegex];
    
    return rt;
    
}

// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum])
        || ([regextestcm evaluateWithObject:mobileNum])
        || ([regextestct evaluateWithObject:mobileNum])
        || ([regextestcu evaluateWithObject:mobileNum]))
    {
        if([regextestcm evaluateWithObject:mobileNum]) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:mobileNum]) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:mobileNum]) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
