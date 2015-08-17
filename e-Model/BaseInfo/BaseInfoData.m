//
//  BaseInfoData.m
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BaseInfoData.h"


NSString *const kBaseInfoDataQQ = @"QQ";
NSString *const kBaseInfoDataRealName = @"realName";
NSString *const kBaseInfoDataAge = @"age";
NSString *const kBaseInfoDataIntroduction = @"introduction";
NSString *const kBaseInfoDataMobile = @"mobile";
NSString *const kBaseInfoDataWechat = @"wechat";
NSString *const kBaseInfoDataSex = @"sex";
NSString *const kBaseInfoDataAvatar = @"avatar";
NSString *const kBaseInfoDataBirthday = @"birthday";
NSString *const kBaseInfoDataService = @"service";
NSString *const kBaseInfoDataNickName = @"nickName";
NSString *const kBaseInfoDataEmail = @"email";


@interface BaseInfoData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseInfoData

@synthesize qQ = _qQ;
@synthesize realName = _realName;
@synthesize age = _age;
@synthesize introduction = _introduction;
@synthesize mobile = _mobile;
@synthesize wechat = _wechat;
@synthesize sex = _sex;
@synthesize avatar = _avatar;
@synthesize birthday = _birthday;
@synthesize service = _service;
@synthesize nickName = _nickName;
@synthesize email = _email;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.qQ = [self objectOrNilForKey:kBaseInfoDataQQ fromDictionary:dict];
            self.realName = [self objectOrNilForKey:kBaseInfoDataRealName fromDictionary:dict];
            self.age = [[self objectOrNilForKey:kBaseInfoDataAge fromDictionary:dict] doubleValue];
            self.introduction = [self objectOrNilForKey:kBaseInfoDataIntroduction fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kBaseInfoDataMobile fromDictionary:dict];
            self.wechat = [self objectOrNilForKey:kBaseInfoDataWechat fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kBaseInfoDataSex fromDictionary:dict];
            self.avatar = [self objectOrNilForKey:kBaseInfoDataAvatar fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kBaseInfoDataBirthday fromDictionary:dict];
            self.service = [self objectOrNilForKey:kBaseInfoDataService fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kBaseInfoDataNickName fromDictionary:dict];
            self.email = [self objectOrNilForKey:kBaseInfoDataEmail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.qQ forKey:kBaseInfoDataQQ];
    [mutableDict setValue:self.realName forKey:kBaseInfoDataRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.age] forKey:kBaseInfoDataAge];
    [mutableDict setValue:self.introduction forKey:kBaseInfoDataIntroduction];
    [mutableDict setValue:self.mobile forKey:kBaseInfoDataMobile];
    [mutableDict setValue:self.wechat forKey:kBaseInfoDataWechat];
    [mutableDict setValue:self.sex forKey:kBaseInfoDataSex];
    [mutableDict setValue:self.avatar forKey:kBaseInfoDataAvatar];
    [mutableDict setValue:self.birthday forKey:kBaseInfoDataBirthday];
    [mutableDict setValue:self.service forKey:kBaseInfoDataService];
    [mutableDict setValue:self.nickName forKey:kBaseInfoDataNickName];
    [mutableDict setValue:self.email forKey:kBaseInfoDataEmail];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.qQ = [aDecoder decodeObjectForKey:kBaseInfoDataQQ];
    self.realName = [aDecoder decodeObjectForKey:kBaseInfoDataRealName];
    self.age = [aDecoder decodeDoubleForKey:kBaseInfoDataAge];
    self.introduction = [aDecoder decodeObjectForKey:kBaseInfoDataIntroduction];
    self.mobile = [aDecoder decodeObjectForKey:kBaseInfoDataMobile];
    self.wechat = [aDecoder decodeObjectForKey:kBaseInfoDataWechat];
    self.sex = [aDecoder decodeObjectForKey:kBaseInfoDataSex];
    self.avatar = [aDecoder decodeObjectForKey:kBaseInfoDataAvatar];
    self.birthday = [aDecoder decodeObjectForKey:kBaseInfoDataBirthday];
    self.service = [aDecoder decodeObjectForKey:kBaseInfoDataService];
    self.nickName = [aDecoder decodeObjectForKey:kBaseInfoDataNickName];
    self.email = [aDecoder decodeObjectForKey:kBaseInfoDataEmail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_qQ forKey:kBaseInfoDataQQ];
    [aCoder encodeObject:_realName forKey:kBaseInfoDataRealName];
    [aCoder encodeDouble:_age forKey:kBaseInfoDataAge];
    [aCoder encodeObject:_introduction forKey:kBaseInfoDataIntroduction];
    [aCoder encodeObject:_mobile forKey:kBaseInfoDataMobile];
    [aCoder encodeObject:_wechat forKey:kBaseInfoDataWechat];
    [aCoder encodeObject:_sex forKey:kBaseInfoDataSex];
    [aCoder encodeObject:_avatar forKey:kBaseInfoDataAvatar];
    [aCoder encodeObject:_birthday forKey:kBaseInfoDataBirthday];
    [aCoder encodeObject:_service forKey:kBaseInfoDataService];
    [aCoder encodeObject:_nickName forKey:kBaseInfoDataNickName];
    [aCoder encodeObject:_email forKey:kBaseInfoDataEmail];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseInfoData *copy = [[BaseInfoData alloc] init];
    
    if (copy) {

        copy.qQ = [self.qQ copyWithZone:zone];
        copy.realName = [self.realName copyWithZone:zone];
        copy.age = self.age;
        copy.introduction = [self.introduction copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.wechat = [self.wechat copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.birthday = [self.birthday copyWithZone:zone];
        copy.service = [self.service copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
    }
    
    return copy;
}


@end
