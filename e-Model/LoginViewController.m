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
@interface LoginViewController ()
{
    EMWHttpManager *manager;
    
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
    ViewController *vc = [[ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [EMWHttpManager getRequestWithUserName:_username WithUserId:_userId WithEmail:_email WithIsEmailCheck:_isEmailCheck WithisMobileCheck:_isMobileCheck WithUserTypeId:_userTypeId BaseClassBlock:^(EMWUser *baseClass){
        self.baseClass = baseClass;
//        NSArray *firstArr = self.baseClass.data;
//        if (array.count == 0) {
//            for (EMWUser* data in firstArr) {
//                [array addObject:data];
//            }
//        }
//        NSLog(@"========%@=======",array);
    }];
    
        
    
    
    
    

}

- (IBAction)registButton:(UIButton *)sender {
    RegistViewController *rv = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:rv animated:YES ];
}

- (IBAction)pwsButton:(id)sender {
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
