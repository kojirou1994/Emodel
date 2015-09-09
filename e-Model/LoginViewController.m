//
//  LoginViewController.m
//  e-Model
//
//  Created by 魏众 on 15/7/20.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "MainViewController.h"
#import "Header.h"
#import "EMWHttpManager.h"
#import "EMWUser.h"
#import "AFHTTPRequestOperationManager.h"
#import "EMWBusinessInfo.h"
#import "DataModels.h"
#import "tockenDataModels.h"
#define SHOW_ALERT(msg) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alert show];

@interface LoginViewController ()
{
    EMWHttpManager *manager;
    userTockenuserTocken *tocken;
}
@property (nonatomic,strong)EMWUser *baseClass;
@property (nonatomic,copy)NSString *applyUserTypeld,*email,*userId,*isEmailCheck,*isMobileCheck,*mobile,*userTypeId,*username;
@property (nonatomic,strong)NSString *useId;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"会员登录";
    UIButton* back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.bounds = CGRectMake(0, 0, 20, 15);
//    [back setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back  setTitle:@"返回" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)loginButton:(UIButton *)sender {
    
//      ViewController *vc = [[ViewController alloc]init];
//      [self.navigationController pushViewController:vc animated:YES];
        NSString *strURL1 = [NSString stringWithFormat:@"http://10.0.1.11/user/login"];
        NSString *post1 =  [NSString stringWithFormat:@"username=%@&password=%@&autoLogin=%ld",self.phoneNumber.text,self.passWord.text, [self.isAutoLogin.text integerValue]];
        //    strURL1 = [strURL1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url1 = [NSURL URLWithString:strURL1];
        NSData *postData1 = [post1 dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url1];
        [request1 setHTTPMethod:@"POST"];
        [request1 setHTTPBody:postData1];
        AFHTTPRequestOperation* operation1 = [[AFHTTPRequestOperation alloc]initWithRequest:request1];
        [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation1,id responseObjecy){
            NSLog(@"-------  %@ *********",operation1.responseString);
            NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:operation1.responseData options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dict1);
            tocken = [[userTockenuserTocken alloc]initWithDictionary:dict1];
            NSLog(@"''''''%@''''",tocken.data.userId);
            if ([[dict1 objectForKey:@"status"]integerValue] == 200) {
               
                [LoginViewController gotoMain];
                NoticeViewController *notice = [[NoticeViewController alloc] init];
                notice.userId = tocken.data.userId;
                notice.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"通告" image:[UIImage imageNamed:@"file@2x"] tag:0];
                UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:notice];
                MessageViewController *message = [[MessageViewController alloc] init];
                message.title = @"我的会话";
                message.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:[UIImage imageNamed:@"main@2x"] tag:1];
                UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:message];
                PersonViewController *person = [[PersonViewController alloc] init];
                person.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"person@2x"] tag:2];
                UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:person];
                UITabBarController *tabBarVC = [[UITabBarController alloc] init];
                tabBarVC.viewControllers = @[nav2,nav3,nav4];
                [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
                tabBarVC.tabBar.tintColor = [UIColor colorWithRed:1.0f green:0.2f blue:0.7f alpha:1.0];
                tabBarVC.selectedIndex = 0;

            }
    
        }
         
            failure:^(AFHTTPRequestOperation *operation,NSError *error)
        {
        if (error.code != NSURLErrorTimedOut)
        {
            NSLog(@"error: %@", error);
        
            SHOW_ALERT(@"用户名/密码不正确");
            

            
        }
                                              
        }];
        
        [operation1 start];


}

- (IBAction)registButton:(UIButton *)sender {
    RegistViewController *rv = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:rv animated:YES ];
}
+ (void)gotoMain
{
    //    MainViewController *main = [[MainViewController alloc] init];
    //    main.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"news@2x"] tag:0];
    //    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:main];
   }

- (IBAction)pwsButton:(id)sender {
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
