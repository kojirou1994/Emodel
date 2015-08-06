//
//  EMWBusinessBaseClass.m
//
//  Created by 众 魏 on 15/8/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "EMWBusinessBaseClass.h"
#import "EMWBusinessData.h"


NSString *const kEMWBusinessBaseClassMessage = @"message";
NSString *const kEMWBusinessBaseClassData = @"data";
NSString *const kEMWBusinessBaseClassStatus = @"status";


@interface EMWBusinessBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EMWBusinessBaseClass

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
            self.message = [self objectOrNilForKey:kEMWBusinessBaseClassMessage fromDictionary:dict];
            self.data = [EMWBusinessData modelObjectWithDictionary:[dict objectForKey:kEMWBusinessBaseClassData]];
            self.status = [[self objectOrNilForKey:kEMWBusinessBaseClassStatus fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEMWBusinessBaseClassMessage];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kEMWBusinessBaseClassData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kEMWBusinessBaseClassStatus];

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

    self.message = [aDecoder decodeObjectForKey:kEMWBusinessBaseClassMessage];
    self.data = [aDecoder decodeObjectForKey:kEMWBusinessBaseClassData];
    self.status = [aDecoder decodeDoubleForKey:kEMWBusinessBaseClassStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEMWBusinessBaseClassMessage];
    [aCoder encodeObject:_data forKey:kEMWBusinessBaseClassData];
    [aCoder encodeDouble:_status forKey:kEMWBusinessBaseClassStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    EMWBusinessBaseClass *copy = [[EMWBusinessBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.status = self.status;
    }
    
    return copy;
}


@end
