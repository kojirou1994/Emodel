//
//  OrderData.m
//
//  Created by 众 魏 on 15/8/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OrderData.h"


NSString *const kOrderDataOrderDate = @"orderDate";
NSString *const kOrderDataStyle = @"style";
NSString *const kOrderDataId = @"id";
NSString *const kOrderDataTimeBucket = @"timeBucket";
NSString *const kOrderDataNote = @"note";
NSString *const kOrderDataContact = @"contact";
NSString *const kOrderDataCreatedAt = @"created_at";
NSString *const kOrderDataMobile = @"mobile";
NSString *const kOrderDataProduct = @"product";
NSString *const kOrderDataIsAgree = @"isAgree";
NSString *const kOrderDataAddress = @"address";
NSString *const kOrderDataNum = @"num";
NSString *const kOrderDataModelId = @"modelId";
NSString *const kOrderDataIsComplete = @"isComplete";
NSString *const kOrderDataCompanyId = @"companyId";


@interface OrderData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderData

@synthesize orderDate = _orderDate;
@synthesize style = _style;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize timeBucket = _timeBucket;
@synthesize note = _note;
@synthesize contact = _contact;
@synthesize createdAt = _createdAt;
@synthesize mobile = _mobile;
@synthesize product = _product;
@synthesize isAgree = _isAgree;
@synthesize address = _address;
@synthesize num = _num;
@synthesize modelId = _modelId;
@synthesize isComplete = _isComplete;
@synthesize companyId = _companyId;


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
            self.orderDate = [self objectOrNilForKey:kOrderDataOrderDate fromDictionary:dict];
            self.style = [self objectOrNilForKey:kOrderDataStyle fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kOrderDataId fromDictionary:dict];
            self.timeBucket = [self objectOrNilForKey:kOrderDataTimeBucket fromDictionary:dict];
            self.note = [self objectOrNilForKey:kOrderDataNote fromDictionary:dict];
            self.contact = [self objectOrNilForKey:kOrderDataContact fromDictionary:dict];
            self.createdAt = [self objectOrNilForKey:kOrderDataCreatedAt fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kOrderDataMobile fromDictionary:dict];
            self.product = [self objectOrNilForKey:kOrderDataProduct fromDictionary:dict];
            self.isAgree = [self objectOrNilForKey:kOrderDataIsAgree fromDictionary:dict];
            self.address = [self objectOrNilForKey:kOrderDataAddress fromDictionary:dict];
            self.num = [[self objectOrNilForKey:kOrderDataNum fromDictionary:dict] doubleValue];
            self.modelId = [self objectOrNilForKey:kOrderDataModelId fromDictionary:dict];
            self.isComplete = [self objectOrNilForKey:kOrderDataIsComplete fromDictionary:dict];
            self.companyId = [self objectOrNilForKey:kOrderDataCompanyId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.orderDate forKey:kOrderDataOrderDate];
    [mutableDict setValue:self.style forKey:kOrderDataStyle];
    [mutableDict setValue:self.dataIdentifier forKey:kOrderDataId];
    [mutableDict setValue:self.timeBucket forKey:kOrderDataTimeBucket];
    [mutableDict setValue:self.note forKey:kOrderDataNote];
    [mutableDict setValue:self.contact forKey:kOrderDataContact];
    [mutableDict setValue:self.createdAt forKey:kOrderDataCreatedAt];
    [mutableDict setValue:self.mobile forKey:kOrderDataMobile];
    [mutableDict setValue:self.product forKey:kOrderDataProduct];
    [mutableDict setValue:self.isAgree forKey:kOrderDataIsAgree];
    [mutableDict setValue:self.address forKey:kOrderDataAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.num] forKey:kOrderDataNum];
    [mutableDict setValue:self.modelId forKey:kOrderDataModelId];
    [mutableDict setValue:self.isComplete forKey:kOrderDataIsComplete];
    [mutableDict setValue:self.companyId forKey:kOrderDataCompanyId];

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

    self.orderDate = [aDecoder decodeObjectForKey:kOrderDataOrderDate];
    self.style = [aDecoder decodeObjectForKey:kOrderDataStyle];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kOrderDataId];
    self.timeBucket = [aDecoder decodeObjectForKey:kOrderDataTimeBucket];
    self.note = [aDecoder decodeObjectForKey:kOrderDataNote];
    self.contact = [aDecoder decodeObjectForKey:kOrderDataContact];
    self.createdAt = [aDecoder decodeObjectForKey:kOrderDataCreatedAt];
    self.mobile = [aDecoder decodeObjectForKey:kOrderDataMobile];
    self.product = [aDecoder decodeObjectForKey:kOrderDataProduct];
    self.isAgree = [aDecoder decodeObjectForKey:kOrderDataIsAgree];
    self.address = [aDecoder decodeObjectForKey:kOrderDataAddress];
    self.num = [aDecoder decodeDoubleForKey:kOrderDataNum];
    self.modelId = [aDecoder decodeObjectForKey:kOrderDataModelId];
    self.isComplete = [aDecoder decodeObjectForKey:kOrderDataIsComplete];
    self.companyId = [aDecoder decodeObjectForKey:kOrderDataCompanyId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderDate forKey:kOrderDataOrderDate];
    [aCoder encodeObject:_style forKey:kOrderDataStyle];
    [aCoder encodeObject:_dataIdentifier forKey:kOrderDataId];
    [aCoder encodeObject:_timeBucket forKey:kOrderDataTimeBucket];
    [aCoder encodeObject:_note forKey:kOrderDataNote];
    [aCoder encodeObject:_contact forKey:kOrderDataContact];
    [aCoder encodeObject:_createdAt forKey:kOrderDataCreatedAt];
    [aCoder encodeObject:_mobile forKey:kOrderDataMobile];
    [aCoder encodeObject:_product forKey:kOrderDataProduct];
    [aCoder encodeObject:_isAgree forKey:kOrderDataIsAgree];
    [aCoder encodeObject:_address forKey:kOrderDataAddress];
    [aCoder encodeDouble:_num forKey:kOrderDataNum];
    [aCoder encodeObject:_modelId forKey:kOrderDataModelId];
    [aCoder encodeObject:_isComplete forKey:kOrderDataIsComplete];
    [aCoder encodeObject:_companyId forKey:kOrderDataCompanyId];
}

- (id)copyWithZone:(NSZone *)zone
{
    OrderData *copy = [[OrderData alloc] init];
    
    if (copy) {

        copy.orderDate = [self.orderDate copyWithZone:zone];
        copy.style = [self.style copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.timeBucket = [self.timeBucket copyWithZone:zone];
        copy.note = [self.note copyWithZone:zone];
        copy.contact = [self.contact copyWithZone:zone];
        copy.createdAt = [self.createdAt copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.product = [self.product copyWithZone:zone];
        copy.isAgree = [self.isAgree copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.num = self.num;
        copy.modelId = [self.modelId copyWithZone:zone];
        copy.isComplete = [self.isComplete copyWithZone:zone];
        copy.companyId = [self.companyId copyWithZone:zone];
    }
    
    return copy;
}


@end
