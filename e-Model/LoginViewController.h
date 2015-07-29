//
//  LoginViewController.h
//  e-Model
//
//  Created by 魏众 on 15/7/20.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    NSMutableData *_data;
    int result;
}
@property (weak, nonatomic) IBOutlet UIImageView *mobileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lockImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)loginButton:(UIButton *)sender;
- (IBAction)registButton:(UIButton *)sender;
- (IBAction)pwsButton:(id)sender;

@end
