//
//  EMWUser.m
//  e-Model
//
//  Created by 魏众 on 15/8/5.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "EMWUser.h"

@implementation EMWUser
+ (EMWUser *)parseUserWithDictionary:(NSDictionary *)dict;
{
    EMWUser *user = [[EMWUser alloc]init];
//    user.mobile = [dict objectForKey:@"applyUserTypeId"];
//    user.applyUserTypeld = [dict objectForKey:@"password"];
//    user.email = [dict objectForKey:@"email"];
//    user.userId = [dict objectForKey:@"id"];
//    user.isEmailCheck = [dict objectForKey:@"isEmailChcek"];
//    user.userTypeId = [dict objectForKey:@"userTypeId"];
//    user.username = [dict objectForKey:@"username"];
    user.data = [dict objectForKey:@"data"];
    user.status = [dict objectForKey:@"status"];
    user.message = [dict objectForKey:@"message"];
        NSLog(@"---------%@+++++++++++",user.userId);
    NSLog(@"---------------%@+++++++++++++++",user.mobile);
    return user;
}
@end
