//
//  OrderOrderBC.m
//
//  Created by 众 魏 on 15/8/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OrderOrderBC.h"
#import "OrderData.h"


NSString *const kOrderOrderBCMessage = @"message";
NSString *const kOrderOrderBCData = @"data";
NSString *const kOrderOrderBCStatus = @"status";


@interface OrderOrderBC ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderOrderBC

@synthesize message = _message;
@synthesize data = _data;
@synthesize status = _status;


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
            self.message = [self objectOrNilForKey:kOrderOrderBCMessage fromDictionary:dict];
    NSObject *receivedOrderData = [dict objectForKey:kOrderOrderBCData];
    NSMutableArray *parsedOrderData = [NSMutableArray array];
    if ([receivedOrderData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOrderData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOrderData addObject:[OrderData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOrderData isKindOfClass:[NSDictionary class]]) {
       [parsedOrderData addObject:[OrderData modelObjectWithDictionary:(NSDictionary *)receivedOrderData]];
    }

    self.data = [NSArray arrayWithArray:parsedOrderData];
            self.status = [self objectOrNilForKey:kOrderOrderBCStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kOrderOrderBCMessage];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kOrderOrderBCData];
    [mutableDict setValue:self.status forKey:kOrderOrderBCStatus];

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

    self.message = [aDecoder decodeObjectForKey:kOrderOrderBCMessage];
    self.data = [aDecoder decodeObjectForKey:kOrderOrderBCData];
    self.status = [aDecoder decodeObjectForKey:kOrderOrderBCStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kOrderOrderBCMessage];
    [aCoder encodeObject:_data forKey:kOrderOrderBCData];
    [aCoder encodeObject:_status forKey:kOrderOrderBCStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    OrderOrderBC *copy = [[OrderOrderBC alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
    }
    
    return copy;
}


@end
