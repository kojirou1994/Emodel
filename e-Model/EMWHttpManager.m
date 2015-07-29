//
//  EMWHttpManager.m
//  e-Model
//
//  Created by 魏众 on 15/7/21.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "EMWHttpManager.h"
#import "Header.h"
@implementation EMWHttpManager

// 判断当前是否已经登录了
+ (BOOL)isLogin
{
    // 首先判断token是否存在
    
    if (GETACCESSTOKEN == nil)
    {
        // 根本就没有登录过
        return NO;
    }
    
    NSDate *expireDate = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_EXPIREDATE];
    
    if ([[NSDate date] compare:expireDate] != NSOrderedAscending)
    {
        // token 过期了
        return NO;
    }
    
    return YES;
}


@end
