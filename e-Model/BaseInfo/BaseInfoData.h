//
//  BaseInfoData.h
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BaseInfoData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *qQ;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) double age;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *wechat;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *service;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *email;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
