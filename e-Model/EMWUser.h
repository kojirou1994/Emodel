//
//  EMWUser.h
//  e-Model
//
//  Created by 魏众 on 15/8/5.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMWUser : NSObject
@property (nonatomic,copy)NSString *applyUserTypeld,*email,*userId,*isEmailCheck,*isMobileCheck,*mobile,*userTypeId,*username,*message,*status;
@property (nonatomic,strong)NSMutableArray *data;
+ (EMWUser *)parseUserWithDictionary:(NSDictionary *)dict;

@end
