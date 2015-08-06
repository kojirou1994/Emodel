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
    NSMutableArray *array;
    NSMutableArray *_arr;
    NSMutableArray *_Arr;
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
    
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://192.168.1.239:5000/user"];
    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager1 GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"-------  %@ -----------",operation.responseString);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSArray *array222 = [dict objectForKey:@"data"];
//        NSLog(@"___++++%ld++++____",array222.count);
        for (NSArray *arr in array222) {
            array = [[NSMutableArray alloc]initWithCapacity:0];
//             NSLog(@"____%@_++++++______",dict);
//            EMWUser *user = [EMWUser parseUserWithDictionary:dict];
            [array addObject:arr];
//            NSLog(@"+++++++%@+++++++",[array objectAtIndex:0]);
            AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
            NSString *url1 = [NSString stringWithFormat:@"http://192.168.1.239:5000/user/%@",[array objectAtIndex:0]];
            manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
            [manager2 GET:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSLog(@"-------  %@ 646656565",operation.responseString);
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
                NSArray *array111 = [dict objectForKey:@"data"];
                for (NSArray *arr in array111) {
                    _arr = [[NSMutableArray alloc]initWithCapacity:0];
                    [_arr addObject:arr];
//                    NSLog(@"_______%@_______",[_arr objectAtIndex:0]);
                    AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
                    NSString *url1 = [NSString stringWithFormat:@"http://192.168.1.239:5000/user/%@/baseinfo",[array objectAtIndex:0]];
                    manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
                    [manager2 GET:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                        NSLog(@"-------  %@ 646656565",operation.responseString);
                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
                        NSArray *array333 = [dict objectForKey:@"data"];
                        for (NSArray *arr111 in array333) {
                            _Arr = [[NSMutableArray alloc]initWithCapacity:0];
                            [_Arr addObject:arr111];
//                            NSLog(@"_______%@_______",[_Arr objectAtIndex:0]);
                        }
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"+++++++  %@+++++++++++",error);
                    }];
                    AFHTTPRequestOperationManager *manager3 = [AFHTTPRequestOperationManager manager];
                    NSString *url2 = [NSString stringWithFormat:@"http://192.168.1.239:5000/user/%@/bodyinfo",[array objectAtIndex:0]];
                    manager3.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
                    [manager3 GET:url2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                        NSLog(@"-------  %@ 646656565",operation.responseString);
                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
                        NSArray *array444 = [dict objectForKey:@"data"];
                        for (NSArray *arr444 in array444) {
                            _Arr = [[NSMutableArray alloc]initWithCapacity:0];
                            [_Arr addObject:arr444];
//                            NSLog(@"_______%@_______",[_Arr objectAtIndex:0]);
                        }
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"+++++++  %@+++++++++++",error);
                    }];
                    AFHTTPRequestOperationManager *manager4 = [AFHTTPRequestOperationManager manager];
                    NSString *url3 = [NSString stringWithFormat:@"http://192.168.1.239:5000/user/%@/businessinfo",[array objectAtIndex:0]];
                    manager4.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
                    [manager4 GET:url3 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSLog(@"-------  %@ 646656565",operation.responseString);
                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
                        NSArray *array555 = [dict objectForKey:@"data"];
                        NSLog(@"+++++++%@_______",array555);
                        for (NSDictionary *dict1 in array555) {
                            _Arr = [[NSMutableArray alloc]initWithCapacity:0];
                            NSLog(@"___________________%@+++++++++",dict1);
                            EMWBusinessBaseClass *baseClass = [[EMWBusinessBaseClass alloc]initWithDictionary:dict];;
                            NSLog(@"!!!!!!!!!!!!!!!!!!%@!!!!!!!!!!!!!!",baseClass);
                            [_Arr addObject:baseClass];
                            NSLog(@"_______%ld_______",_Arr.count);
                            NSLog(@"++++++++++%lf___+++_+_+_+_+",baseClass.data.inPrice);
                        }
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"+++++++  %@+++++++++++",error);
                    }];


                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"+++++++  %@+++++++++++",error);
            }];
        }

        _userId = [array objectAtIndex:0];
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"+++++++  %@+++++++++++",error);
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
