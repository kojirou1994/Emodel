//
//  EMWBusinessData.m
//
//  Created by 众 魏 on 15/8/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "EMWBusinessData.h"


NSString *const kEMWBusinessDataOutPrice = @"outPrice";
NSString *const kEMWBusinessDataUnderwearPrice = @"underwearPrice";
NSString *const kEMWBusinessDataInPrice = @"inPrice";
NSString *const kEMWBusinessDataDayPrice = @"dayPrice";
NSString *const kEMWBusinessDataStartCount = @"startCount";


@interface EMWBusinessData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EMWBusinessData

@synthesize outPrice = _outPrice;
@synthesize underwearPrice = _underwearPrice;
@synthesize inPrice = _inPrice;
@synthesize dayPrice = _dayPrice;
@synthesize startCount = _startCount;


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
            self.outPrice = [[self objectOrNilForKey:kEMWBusinessDataOutPrice fromDictionary:dict] doubleValue];
            self.underwearPrice = [[self objectOrNilForKey:kEMWBusinessDataUnderwearPrice fromDictionary:dict] doubleValue];
            self.inPrice = [[self objectOrNilForKey:kEMWBusinessDataInPrice fromDictionary:dict] doubleValue];
            self.dayPrice = [[self objectOrNilForKey:kEMWBusinessDataDayPrice fromDictionary:dict] doubleValue];
            self.startCount = [[self objectOrNilForKey:kEMWBusinessDataStartCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.outPrice] forKey:kEMWBusinessDataOutPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.underwearPrice] forKey:kEMWBusinessDataUnderwearPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inPrice] forKey:kEMWBusinessDataInPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dayPrice] forKey:kEMWBusinessDataDayPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startCount] forKey:kEMWBusinessDataStartCount];

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

    self.outPrice = [aDecoder decodeDoubleForKey:kEMWBusinessDataOutPrice];
    self.underwearPrice = [aDecoder decodeDoubleForKey:kEMWBusinessDataUnderwearPrice];
    self.inPrice = [aDecoder decodeDoubleForKey:kEMWBusinessDataInPrice];
    self.dayPrice = [aDecoder decodeDoubleForKey:kEMWBusinessDataDayPrice];
    self.startCount = [aDecoder decodeDoubleForKey:kEMWBusinessDataStartCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_outPrice forKey:kEMWBusinessDataOutPrice];
    [aCoder encodeDouble:_underwearPrice forKey:kEMWBusinessDataUnderwearPrice];
    [aCoder encodeDouble:_inPrice forKey:kEMWBusinessDataInPrice];
    [aCoder encodeDouble:_dayPrice forKey:kEMWBusinessDataDayPrice];
    [aCoder encodeDouble:_startCount forKey:kEMWBusinessDataStartCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    EMWBusinessData *copy = [[EMWBusinessData alloc] init];
    
    if (copy) {

        copy.outPrice = self.outPrice;
        copy.underwearPrice = self.underwearPrice;
        copy.inPrice = self.inPrice;
        copy.dayPrice = self.dayPrice;
        copy.startCount = self.startCount;
    }
    
    return copy;
}


@end
