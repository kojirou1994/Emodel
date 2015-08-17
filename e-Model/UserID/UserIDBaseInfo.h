//
//  UserIDBaseInfo.h
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserIDMedia;

@interface UserIDBaseInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) double age;
@property (nonatomic, strong) UserIDMedia *media;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *qQ;
@property (nonatomic, strong) NSString *nickName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
