//
//  EMWHttpManager.h
//  e-Model
//
//  Created by 魏众 on 15/7/21.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestBlock)(BOOL isSuccessed,NSString *errorMessage);
typedef void(^ArrayBlock)(NSMutableArray *array,NSString *errorMessage);

@interface EMWHttpManager : NSObject

+ (BOOL)isLogin;





@end
