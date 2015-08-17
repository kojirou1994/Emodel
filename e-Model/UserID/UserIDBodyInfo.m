//
//  UserIDBodyInfo.m
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserIDBodyInfo.h"


NSString *const kUserIDBodyInfoWaist = @"waist";
NSString *const kUserIDBodyInfoShoeSize = @"shoeSize";
NSString *const kUserIDBodyInfoIntroduction = @"introduction";
NSString *const kUserIDBodyInfoClothesSize = @"clothesSize";
NSString *const kUserIDBodyInfoTrousers = @"trousers";
NSString *const kUserIDBodyInfoWeight = @"weight";
NSString *const kUserIDBodyInfoBloodType = @"bloodType";
NSString *const kUserIDBodyInfoWaistline = @"waistline";
NSString *const kUserIDBodyInfoBust = @"bust";
NSString *const kUserIDBodyInfoService = @"service";
NSString *const kUserIDBodyInfoHeight = @"height";
NSString *const kUserIDBodyInfoHips = @"hips";
NSString *const kUserIDBodyInfoCup = @"cup";


@interface UserIDBodyInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserIDBodyInfo

@synthesize waist = _waist;
@synthesize shoeSize = _shoeSize;
@synthesize introduction = _introduction;
@synthesize clothesSize = _clothesSize;
@synthesize trousers = _trousers;
@synthesize weight = _weight;
@synthesize bloodType = _bloodType;
@synthesize waistline = _waistline;
@synthesize bust = _bust;
@synthesize service = _service;
@synthesize height = _height;
@synthesize hips = _hips;
@synthesize cup = _cup;


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
            self.waist = [self objectOrNilForKey:kUserIDBodyInfoWaist fromDictionary:dict];
            self.shoeSize = [self objectOrNilForKey:kUserIDBodyInfoShoeSize fromDictionary:dict];
            self.introduction = [self objectOrNilForKey:kUserIDBodyInfoIntroduction fromDictionary:dict];
            self.clothesSize = [self objectOrNilForKey:kUserIDBodyInfoClothesSize fromDictionary:dict];
            self.trousers = [self objectOrNilForKey:kUserIDBodyInfoTrousers fromDictionary:dict];
            self.weight = [self objectOrNilForKey:kUserIDBodyInfoWeight fromDictionary:dict];
            self.bloodType = [self objectOrNilForKey:kUserIDBodyInfoBloodType fromDictionary:dict];
            self.waistline = [[self objectOrNilForKey:kUserIDBodyInfoWaistline fromDictionary:dict] doubleValue];
            self.bust = [[self objectOrNilForKey:kUserIDBodyInfoBust fromDictionary:dict] doubleValue];
            self.service = [self objectOrNilForKey:kUserIDBodyInfoService fromDictionary:dict];
            self.height = [self objectOrNilForKey:kUserIDBodyInfoHeight fromDictionary:dict];
            self.hips = [[self objectOrNilForKey:kUserIDBodyInfoHips fromDictionary:dict] doubleValue];
            self.cup = [self objectOrNilForKey:kUserIDBodyInfoCup fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.waist forKey:kUserIDBodyInfoWaist];
    [mutableDict setValue:self.shoeSize forKey:kUserIDBodyInfoShoeSize];
    [mutableDict setValue:self.introduction forKey:kUserIDBodyInfoIntroduction];
    [mutableDict setValue:self.clothesSize forKey:kUserIDBodyInfoClothesSize];
    [mutableDict setValue:self.trousers forKey:kUserIDBodyInfoTrousers];
    [mutableDict setValue:self.weight forKey:kUserIDBodyInfoWeight];
    [mutableDict setValue:self.bloodType forKey:kUserIDBodyInfoBloodType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.waistline] forKey:kUserIDBodyInfoWaistline];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bust] forKey:kUserIDBodyInfoBust];
    [mutableDict setValue:self.service forKey:kUserIDBodyInfoService];
    [mutableDict setValue:self.height forKey:kUserIDBodyInfoHeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hips] forKey:kUserIDBodyInfoHips];
    [mutableDict setValue:self.cup forKey:kUserIDBodyInfoCup];

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

    self.waist = [aDecoder decodeObjectForKey:kUserIDBodyInfoWaist];
    self.shoeSize = [aDecoder decodeObjectForKey:kUserIDBodyInfoShoeSize];
    self.introduction = [aDecoder decodeObjectForKey:kUserIDBodyInfoIntroduction];
    self.clothesSize = [aDecoder decodeObjectForKey:kUserIDBodyInfoClothesSize];
    self.trousers = [aDecoder decodeObjectForKey:kUserIDBodyInfoTrousers];
    self.weight = [aDecoder decodeObjectForKey:kUserIDBodyInfoWeight];
    self.bloodType = [aDecoder decodeObjectForKey:kUserIDBodyInfoBloodType];
    self.waistline = [aDecoder decodeDoubleForKey:kUserIDBodyInfoWaistline];
    self.bust = [aDecoder decodeDoubleForKey:kUserIDBodyInfoBust];
    self.service = [aDecoder decodeObjectForKey:kUserIDBodyInfoService];
    self.height = [aDecoder decodeObjectForKey:kUserIDBodyInfoHeight];
    self.hips = [aDecoder decodeDoubleForKey:kUserIDBodyInfoHips];
    self.cup = [aDecoder decodeObjectForKey:kUserIDBodyInfoCup];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_waist forKey:kUserIDBodyInfoWaist];
    [aCoder encodeObject:_shoeSize forKey:kUserIDBodyInfoShoeSize];
    [aCoder encodeObject:_introduction forKey:kUserIDBodyInfoIntroduction];
    [aCoder encodeObject:_clothesSize forKey:kUserIDBodyInfoClothesSize];
    [aCoder encodeObject:_trousers forKey:kUserIDBodyInfoTrousers];
    [aCoder encodeObject:_weight forKey:kUserIDBodyInfoWeight];
    [aCoder encodeObject:_bloodType forKey:kUserIDBodyInfoBloodType];
    [aCoder encodeDouble:_waistline forKey:kUserIDBodyInfoWaistline];
    [aCoder encodeDouble:_bust forKey:kUserIDBodyInfoBust];
    [aCoder encodeObject:_service forKey:kUserIDBodyInfoService];
    [aCoder encodeObject:_height forKey:kUserIDBodyInfoHeight];
    [aCoder encodeDouble:_hips forKey:kUserIDBodyInfoHips];
    [aCoder encodeObject:_cup forKey:kUserIDBodyInfoCup];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserIDBodyInfo *copy = [[UserIDBodyInfo alloc] init];
    
    if (copy) {

        copy.waist = [self.waist copyWithZone:zone];
        copy.shoeSize = [self.shoeSize copyWithZone:zone];
        copy.introduction = [self.introduction copyWithZone:zone];
        copy.clothesSize = [self.clothesSize copyWithZone:zone];
        copy.trousers = [self.trousers copyWithZone:zone];
        copy.weight = [self.weight copyWithZone:zone];
        copy.bloodType = [self.bloodType copyWithZone:zone];
        copy.waistline = self.waistline;
        copy.bust = self.bust;
        copy.service = [self.service copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.hips = self.hips;
        copy.cup = [self.cup copyWithZone:zone];
    }
    
    return copy;
}


@end
