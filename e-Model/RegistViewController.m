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
@interface RegistViewController ()
{
    NSMutableData *_data;
}
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"会员注册";
    _data = [[NSMutableData alloc]init];
    
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
    [EMWHttpManager signUpWithUserName:(NSString*)_phoneNumber WithPassWord:(NSString *)_pws WithConfirm_tocken:(NSString *)_phoneIdentifying WithConfirm:(NSString *)_surePassWord BaseClassBlock:^(EMWUser *baseData){
        self.baseClass = baseData;
    
    
    }];
}
- (IBAction)confirm_tockenBtn:(UIButton *)sender
{
    
    // 获取验证码
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://191.168.1.239:5000/user"];
    NSDictionary *parameters = @{@"mobile":_phoneNumber,@"confirm_tocken":_pws,@"confirm":_phoneIdentifying};
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"-------  %@",operation.responseString);
        [RegistViewController isValidateTelNumber:_phoneNumber.text];
        [self isMobileNumber:_phoneNumber.text];
//        EMWUser *baseData = [EMWUser parseUserWithDictionary:responseObject];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"+++++++  %@",error);
    }];
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
