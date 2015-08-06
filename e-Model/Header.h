//
//  Header.h
//  e-Model
//
//  Created by 魏众 on 15/7/21.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#ifndef e_Model_Header_h
#define e_Model_Header_h
#import "EMWHttpManager.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "MessageViewController.h"
#import "NoticeViewController.h"
#import "PersonViewController.h"
#import "ViewController.h"
#import "SeachViewController.h"
#import "WomanModelViewController.h"
#import "ManModelViewController.h"
#import "ChildModelViewController.h"
#import "ForeignManViewController.h"
#import "ForeignWomanModelViewController.h"
#import "OldModelViewController.h"
#define GETACCESSTOKEN  [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ACCESSTOKEN]
#define SHOWALERT(messageString)    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:messageString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];[alert show];[alert release];
#define KEY_ACCESSTOKEN @"access_token"
#define KEY_EXPIREDATE @"date"
#endif
