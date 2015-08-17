//
//  UserIDData.h
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserIDBodyInfo, UserIDBusinessInfo, UserIDBaseInfo;

@interface UserIDData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double cityId;
@property (nonatomic, assign) double star;
@property (nonatomic, strong) UserIDBodyInfo *bodyInfo;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) UserIDBusinessInfo *businessInfo;
@property (nonatomic, assign) double userTypeId;
@property (nonatomic, strong) NSString *modelCard;
@property (nonatomic, strong) UserIDBaseInfo *baseInfo;
@property (nonatomic, assign) id userTypeName;
@property (nonatomic, assign) double viewCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
