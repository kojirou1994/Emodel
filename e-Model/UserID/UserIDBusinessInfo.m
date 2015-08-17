//
//  UserIDBusinessInfo.m
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserIDBusinessInfo.h"


NSString *const kUserIDBusinessInfoDayPrice = @"dayPrice";
NSString *const kUserIDBusinessInfoStartCount = @"startCount";
NSString *const kUserIDBusinessInfoInPrice = @"inPrice";
NSString *const kUserIDBusinessInfoUnderwearPrice = @"underwearPrice";
NSString *const kUserIDBusinessInfoOutPrice = @"outPrice";


@interface UserIDBusinessInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserIDBusinessInfo

@synthesize dayPrice = _dayPrice;
@synthesize startCount = _startCount;
@synthesize inPrice = _inPrice;
@synthesize underwearPrice = _underwearPrice;
@synthesize outPrice = _outPrice;


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
            self.dayPrice = [[self objectOrNilForKey:kUserIDBusinessInfoDayPrice fromDictionary:dict] doubleValue];
            self.startCount = [[self objectOrNilForKey:kUserIDBusinessInfoStartCount fromDictionary:dict] doubleValue];
            self.inPrice = [[self objectOrNilForKey:kUserIDBusinessInfoInPrice fromDictionary:dict] doubleValue];
            self.underwearPrice = [[self objectOrNilForKey:kUserIDBusinessInfoUnderwearPrice fromDictionary:dict] doubleValue];
            self.outPrice = [[self objectOrNilForKey:kUserIDBusinessInfoOutPrice fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dayPrice] forKey:kUserIDBusinessInfoDayPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCount] forKey:kUserIDBusinessInfoStartCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inPrice] forKey:kUserIDBusinessInfoInPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.underwearPrice] forKey:kUserIDBusinessInfoUnderwearPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.outPrice] forKey:kUserIDBusinessInfoOutPrice];

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

    self.dayPrice = [aDecoder decodeDoubleForKey:kUserIDBusinessInfoDayPrice];
    self.startCount = [aDecoder decodeDoubleForKey:kUserIDBusinessInfoStartCount];
    self.inPrice = [aDecoder decodeDoubleForKey:kUserIDBusinessInfoInPrice];
    self.underwearPrice = [aDecoder decodeDoubleForKey:kUserIDBusinessInfoUnderwearPrice];
    self.outPrice = [aDecoder decodeDoubleForKey:kUserIDBusinessInfoOutPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_dayPrice forKey:kUserIDBusinessInfoDayPrice];
    [aCoder encodeDouble:_startCount forKey:kUserIDBusinessInfoStartCount];
    [aCoder encodeDouble:_inPrice forKey:kUserIDBusinessInfoInPrice];
    [aCoder encodeDouble:_underwearPrice forKey:kUserIDBusinessInfoUnderwearPrice];
    [aCoder encodeDouble:_outPrice forKey:kUserIDBusinessInfoOutPrice];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserIDBusinessInfo *copy = [[UserIDBusinessInfo alloc] init];
    
    if (copy) {

        copy.dayPrice = self.dayPrice;
        copy.startCount = self.startCount;
        copy.inPrice = self.inPrice;
        copy.underwearPrice = self.underwearPrice;
        copy.outPrice = self.outPrice;
    }
    
    return copy;
}


@end
