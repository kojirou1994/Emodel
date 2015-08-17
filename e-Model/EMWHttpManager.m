//
//  EMWHttpManager.m
//  e-Model
//
//  Created by 魏众 on 15/7/21.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "EMWHttpManager.h"
#import "Header.h"
#import "EMWUser.h"
#import "AFHTTPRequestOperationManager.h"
@implementation EMWHttpManager
{
    EMWUser *user;
}

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
+ (void)signUpWithUserName:(NSString*)mobile WithPassWord:(NSString *)passWord WithConfirm_tocken:(NSString *)confirm_tocken WithConfirm:(NSString *)confirm BaseClassBlock:(void(^)(EMWUser *baseData))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://191.168.1.239:5000/user/signup"];
    NSDictionary *parameters = @{@"mobile":mobile,@"passWord":passWord,@"confirm_tocken":confirm_tocken,@"confirm":confirm};
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"-------  %@",operation.responseString);
        EMWUser *baseData = [EMWUser parseUserWithDictionary:responseObject];
        block(baseData);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"+++++++  %@",error);
    }];
}
+ (void)getRequestWithUserName:(NSString *)userName WithUserId:(NSString *)userId WithEmail:(NSString *)email WithIsEmailCheck:(NSString *)isEmailCheck WithisMobileCheck:(NSString *)isMobileCheck WithUserTypeId:(NSString *)userTypeId BaseClassBlock:(void(^)(EMWUser *baseData))block
{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSString *url = [NSString stringWithFormat:@"http://192.168.1.239:5000/user"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"-------  %@",operation.responseString);
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
//        NSDictionary *userDict = [dict objectForKey:@"data"];
//        for (NSArray *array in userDict) {
//            NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
//            [arr addObject:array];
////            NSLog(@"_____%@222222222222",arr);
//        }
////        NSLog(@"1111111111111111222222%@3333333344444",userId);
//        
//        EMWUser *baseData = [EMWUser parseUserWithDictionary:userDict];
////        NSLog(@"______%@____",userDict);
//        block(baseData);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"+++++++  %@",error);
//    }];
}






//+ (void)getRequestWithUserId:(NSString *)use
@end
