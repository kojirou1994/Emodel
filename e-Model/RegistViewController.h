//
//  RegistViewController.h
//  e-Model
//
//  Created by 魏众 on 15/7/20.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *phoneIdentifying;
@property (weak, nonatomic) IBOutlet UITextField *pws;
@property (weak, nonatomic) IBOutlet UITextField *surePassWord;

@property (weak, nonatomic) IBOutlet UIImageView *phoneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *identifyingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pwsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *surePassWordImageView;
- (IBAction)sureButton:(UIButton *)sender;


@end
