//
//  UserIDBaseInfo.m
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserIDBaseInfo.h"
#import "UserIDMedia.h"


NSString *const kUserIDBaseInfoMobile = @"mobile";
NSString *const kUserIDBaseInfoAvatar = @"avatar";
NSString *const kUserIDBaseInfoRealName = @"realName";
NSString *const kUserIDBaseInfoAge = @"age";
NSString *const kUserIDBaseInfoMedia = @"media";
NSString *const kUserIDBaseInfoBirthday = @"birthday";
NSString *const kUserIDBaseInfoEmail = @"email";
NSString *const kUserIDBaseInfoQQ = @"QQ";
NSString *const kUserIDBaseInfoNickName = @"nickName";


@interface UserIDBaseInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserIDBaseInfo

@synthesize mobile = _mobile;
@synthesize avatar = _avatar;
@synthesize realName = _realName;
@synthesize age = _age;
@synthesize media = _media;
@synthesize birthday = _birthday;
@synthesize email = _email;
@synthesize qQ = _qQ;
@synthesize nickName = _nickName;


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
            self.mobile = [self objectOrNilForKey:kUserIDBaseInfoMobile fromDictionary:dict];
            self.avatar = [self objectOrNilForKey:kUserIDBaseInfoAvatar fromDictionary:dict];
            self.realName = [self objectOrNilForKey:kUserIDBaseInfoRealName fromDictionary:dict];
            self.age = [[self objectOrNilForKey:kUserIDBaseInfoAge fromDictionary:dict] doubleValue];
            self.media = [UserIDMedia modelObjectWithDictionary:[dict objectForKey:kUserIDBaseInfoMedia]];
            self.birthday = [self objectOrNilForKey:kUserIDBaseInfoBirthday fromDictionary:dict];
            self.email = [self objectOrNilForKey:kUserIDBaseInfoEmail fromDictionary:dict];
            self.qQ = [self objectOrNilForKey:kUserIDBaseInfoQQ fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kUserIDBaseInfoNickName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobile forKey:kUserIDBaseInfoMobile];
    [mutableDict setValue:self.avatar forKey:kUserIDBaseInfoAvatar];
    [mutableDict setValue:self.realName forKey:kUserIDBaseInfoRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.age] forKey:kUserIDBaseInfoAge];
    [mutableDict setValue:[self.media dictionaryRepresentation] forKey:kUserIDBaseInfoMedia];
    [mutableDict setValue:self.birthday forKey:kUserIDBaseInfoBirthday];
    [mutableDict setValue:self.email forKey:kUserIDBaseInfoEmail];
    [mutableDict setValue:self.qQ forKey:kUserIDBaseInfoQQ];
    [mutableDict setValue:self.nickName forKey:kUserIDBaseInfoNickName];

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

    self.mobile = [aDecoder decodeObjectForKey:kUserIDBaseInfoMobile];
    self.avatar = [aDecoder decodeObjectForKey:kUserIDBaseInfoAvatar];
    self.realName = [aDecoder decodeObjectForKey:kUserIDBaseInfoRealName];
    self.age = [aDecoder decodeDoubleForKey:kUserIDBaseInfoAge];
    self.media = [aDecoder decodeObjectForKey:kUserIDBaseInfoMedia];
    self.birthday = [aDecoder decodeObjectForKey:kUserIDBaseInfoBirthday];
    self.email = [aDecoder decodeObjectForKey:kUserIDBaseInfoEmail];
    self.qQ = [aDecoder decodeObjectForKey:kUserIDBaseInfoQQ];
    self.nickName = [aDecoder decodeObjectForKey:kUserIDBaseInfoNickName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobile forKey:kUserIDBaseInfoMobile];
    [aCoder encodeObject:_avatar forKey:kUserIDBaseInfoAvatar];
    [aCoder encodeObject:_realName forKey:kUserIDBaseInfoRealName];
    [aCoder encodeDouble:_age forKey:kUserIDBaseInfoAge];
    [aCoder encodeObject:_media forKey:kUserIDBaseInfoMedia];
    [aCoder encodeObject:_birthday forKey:kUserIDBaseInfoBirthday];
    [aCoder encodeObject:_email forKey:kUserIDBaseInfoEmail];
    [aCoder encodeObject:_qQ forKey:kUserIDBaseInfoQQ];
    [aCoder encodeObject:_nickName forKey:kUserIDBaseInfoNickName];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserIDBaseInfo *copy = [[UserIDBaseInfo alloc] init];
    
    if (copy) {

        copy.mobile = [self.mobile copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.realName = [self.realName copyWithZone:zone];
        copy.age = self.age;
        copy.media = [self.media copyWithZone:zone];
        copy.birthday = [self.birthday copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
        copy.qQ = [self.qQ copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
    }
    
    return copy;
}


@end
