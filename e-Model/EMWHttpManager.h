//
//  EMWHttpManager.h
//  e-Model
//
//  Created by 魏众 on 15/7/21.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMWUser.h"
typedef void(^RequestBlock)(BOOL isSuccessed,NSString *errorMessage);
typedef void(^ArrayBlock)(NSMutableArray *array,NSString *errorMessage);

@interface EMWHttpManager : NSObject
+ (BOOL)isLogin;
+ (void)signUpWithUserName:(NSString*)userName WithPassWord:(NSString *)passWord WithConfirm_tocken:(NSString *)confirm_tocken WithConfirm:(NSString *)confirm BaseClassBlock:(void(^)(EMWUser *baseData))block;
+ (void)getRequestWithUserName:(NSString *)userName WithUserId:(NSString *)userId WithEmail:(NSString *)email WithIsEmailCheck:(NSString *)isEmailCheck WithisMobileCheck:(NSString *)isMobileCheck WithUserTypeId:(NSString *)userTypeId BaseClassBlock:(void(^)(EMWUser *baseData))block;



@end
