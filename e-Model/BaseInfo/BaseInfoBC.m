//
//  BaseInfoBC.m
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BaseInfoBC.h"
#import "BaseInfoData.h"


NSString *const kBaseInfoBCStatus = @"status";
NSString *const kBaseInfoBCData = @"data";


@interface BaseInfoBC ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseInfoBC

@synthesize status = _status;
@synthesize data = _data;


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
            self.status = [[self objectOrNilForKey:kBaseInfoBCStatus fromDictionary:dict] doubleValue];
            self.data = [BaseInfoData modelObjectWithDictionary:[dict objectForKey:kBaseInfoBCData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kBaseInfoBCStatus];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kBaseInfoBCData];

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

    self.status = [aDecoder decodeDoubleForKey:kBaseInfoBCStatus];
    self.data = [aDecoder decodeObjectForKey:kBaseInfoBCData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kBaseInfoBCStatus];
    [aCoder encodeObject:_data forKey:kBaseInfoBCData];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseInfoBC *copy = [[BaseInfoBC alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
