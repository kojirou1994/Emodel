//
//  UserIDData.m
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserIDData.h"
#import "UserIDBodyInfo.h"
#import "UserIDBusinessInfo.h"
#import "UserIDBaseInfo.h"


NSString *const kUserIDDataCityId = @"cityId";
NSString *const kUserIDDataStar = @"star";
NSString *const kUserIDDataBodyInfo = @"bodyInfo";
NSString *const kUserIDDataId = @"id";
NSString *const kUserIDDataBusinessInfo = @"businessInfo";
NSString *const kUserIDDataUserTypeId = @"userTypeId";
NSString *const kUserIDDataModelCard = @"modelCard";
NSString *const kUserIDDataBaseInfo = @"baseInfo";
NSString *const kUserIDDataUserTypeName = @"userTypeName";
NSString *const kUserIDDataViewCount = @"viewCount";


@interface UserIDData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserIDData

@synthesize cityId = _cityId;
@synthesize star = _star;
@synthesize bodyInfo = _bodyInfo;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize businessInfo = _businessInfo;
@synthesize userTypeId = _userTypeId;
@synthesize modelCard = _modelCard;
@synthesize baseInfo = _baseInfo;
@synthesize userTypeName = _userTypeName;
@synthesize viewCount = _viewCount;


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
            self.cityId = [[self objectOrNilForKey:kUserIDDataCityId fromDictionary:dict] doubleValue];
            self.star = [[self objectOrNilForKey:kUserIDDataStar fromDictionary:dict] doubleValue];
            self.bodyInfo = [UserIDBodyInfo modelObjectWithDictionary:[dict objectForKey:kUserIDDataBodyInfo]];
            self.dataIdentifier = [self objectOrNilForKey:kUserIDDataId fromDictionary:dict];
            self.businessInfo = [UserIDBusinessInfo modelObjectWithDictionary:[dict objectForKey:kUserIDDataBusinessInfo]];
            self.userTypeId = [[self objectOrNilForKey:kUserIDDataUserTypeId fromDictionary:dict] doubleValue];
            self.modelCard = [self objectOrNilForKey:kUserIDDataModelCard fromDictionary:dict];
            self.baseInfo = [UserIDBaseInfo modelObjectWithDictionary:[dict objectForKey:kUserIDDataBaseInfo]];
            self.userTypeName = [self objectOrNilForKey:kUserIDDataUserTypeName fromDictionary:dict];
            self.viewCount = [[self objectOrNilForKey:kUserIDDataViewCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kUserIDDataCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.star] forKey:kUserIDDataStar];
    [mutableDict setValue:[self.bodyInfo dictionaryRepresentation] forKey:kUserIDDataBodyInfo];
    [mutableDict setValue:self.dataIdentifier forKey:kUserIDDataId];
    [mutableDict setValue:[self.businessInfo dictionaryRepresentation] forKey:kUserIDDataBusinessInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userTypeId] forKey:kUserIDDataUserTypeId];
    [mutableDict setValue:self.modelCard forKey:kUserIDDataModelCard];
    [mutableDict setValue:[self.baseInfo dictionaryRepresentation] forKey:kUserIDDataBaseInfo];
    [mutableDict setValue:self.userTypeName forKey:kUserIDDataUserTypeName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.viewCount] forKey:kUserIDDataViewCount];

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

    self.cityId = [aDecoder decodeDoubleForKey:kUserIDDataCityId];
    self.star = [aDecoder decodeDoubleForKey:kUserIDDataStar];
    self.bodyInfo = [aDecoder decodeObjectForKey:kUserIDDataBodyInfo];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kUserIDDataId];
    self.businessInfo = [aDecoder decodeObjectForKey:kUserIDDataBusinessInfo];
    self.userTypeId = [aDecoder decodeDoubleForKey:kUserIDDataUserTypeId];
    self.modelCard = [aDecoder decodeObjectForKey:kUserIDDataModelCard];
    self.baseInfo = [aDecoder decodeObjectForKey:kUserIDDataBaseInfo];
    self.userTypeName = [aDecoder decodeObjectForKey:kUserIDDataUserTypeName];
    self.viewCount = [aDecoder decodeDoubleForKey:kUserIDDataViewCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_cityId forKey:kUserIDDataCityId];
    [aCoder encodeDouble:_star forKey:kUserIDDataStar];
    [aCoder encodeObject:_bodyInfo forKey:kUserIDDataBodyInfo];
    [aCoder encodeObject:_dataIdentifier forKey:kUserIDDataId];
    [aCoder encodeObject:_businessInfo forKey:kUserIDDataBusinessInfo];
    [aCoder encodeDouble:_userTypeId forKey:kUserIDDataUserTypeId];
    [aCoder encodeObject:_modelCard forKey:kUserIDDataModelCard];
    [aCoder encodeObject:_baseInfo forKey:kUserIDDataBaseInfo];
    [aCoder encodeObject:_userTypeName forKey:kUserIDDataUserTypeName];
    [aCoder encodeDouble:_viewCount forKey:kUserIDDataViewCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserIDData *copy = [[UserIDData alloc] init];
    
    if (copy) {

        copy.cityId = self.cityId;
        copy.star = self.star;
        copy.bodyInfo = [self.bodyInfo copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.businessInfo = [self.businessInfo copyWithZone:zone];
        copy.userTypeId = self.userTypeId;
        copy.modelCard = [self.modelCard copyWithZone:zone];
        copy.baseInfo = [self.baseInfo copyWithZone:zone];
        copy.userTypeName = [self.userTypeName copyWithZone:zone];
        copy.viewCount = self.viewCount;
    }
    
    return copy;
}


@end
