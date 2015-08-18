//
//  ViewController.m
//  e-Model
//
//  Created by 魏众 on 15/7/20.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "Header.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageView = [[UIImageView alloc]init];
    _imageView.image = [UIImage imageNamed:@""];
    _imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageView];
    [self performSelector:@selector(flash) withObject:nil afterDelay:2];
    
}
- (void)flash
{
    LoginViewController *lv = [[LoginViewController alloc]init];
    UINavigationController *nav= [[UINavigationController alloc]initWithRootViewController:lv];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = nav;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    _imageView.alpha = 0;

//        if ([EMWHttpManager isLogin])
//    {
//        [ViewController gotoMain];
//    }
//    else
//    {
//        LoginViewController *LoginVC = [[LoginViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:LoginVC];
//        self.view.window.rootViewController = nav;
//    }
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:window cache:YES];
    [UIView commitAnimations];
}
//用来显示主页的
//+ (void)gotoMain2
//{
//    MainViewController *main = [[MainViewController alloc] init];
//    MessageViewController *message = [[MessageViewController alloc] init];
//    NoticeViewController *notice = [[NoticeViewController alloc] init];
//    PersonViewController *person = [[PersonViewController alloc] init];
//    NSArray *vcArray = @[main, message, notice, person];
//    
//    NSArray *titleArray = @[@"首页",@"消息",@"通告",@"我"];
//    
//    NSArray *imageNameArray = @[@"main",@"news",@"file",@"person"];
//    
//    NSMutableArray *navArray = [NSMutableArray array];
//    
//    for (int i = 0; i < 4; i++)
//    {
//        UIViewController *vc = vcArray[i];
//        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArray[i] image:[UIImage imageNamed:imageNameArray[i]] tag:i];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//        [navArray addObject:nav];
//    }
//    
//    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
//    tabBarVC.viewControllers = navArray;
//    
//    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
