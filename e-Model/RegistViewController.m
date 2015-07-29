//
//  RegistViewController.m
//  e-Model
//
//  Created by 魏众 on 15/7/20.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "RegistViewController.h"
#import "MainViewController.h"
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
    NSURL *url = [NSURL URLWithString:@"http://191.168.1.233:8080/st/s"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *urlString = [NSString stringWithFormat:@"command=ST_L&name=%@&psw=%@",_phoneNumber.text,_pws.text];
    NSData *data = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //响应后,初始化数据
    [_data setData:[NSData data]];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //接收数据,拼接数据
    [_data appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *string = [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    if ([[dic objectForKey:@"result"]integerValue] == 1) {
        [[NSUserDefaults standardUserDefaults]setObject:_phoneNumber.text forKey:@"name"];
        [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"access_token"] forKey:@"token"];
        NSLog(@"access_token -------22222--------%@",[dic objectForKey:@"access_token"]) ;
        NSDate *nowDate = [NSDate date];
        int time = [[dic objectForKey:@"time"] integerValue];
        NSDate *endDate = [nowDate dateByAddingTimeInterval:time];
        [[NSUserDefaults standardUserDefaults]setObject:endDate forKey:@"endDate"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        MainViewController *mv = [[MainViewController alloc]init];
        [self.navigationController pushViewController:mv animated:YES];
    }
}
@end
