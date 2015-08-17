//
//  UserIDMedia.m
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserIDMedia.h"


NSString *const kUserIDMediaUrl = @"url";
NSString *const kUserIDMediaImgUrl = @"imgUrl";


@interface UserIDMedia ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserIDMedia

@synthesize url = _url;
@synthesize imgUrl = _imgUrl;


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
            self.url = [self objectOrNilForKey:kUserIDMediaUrl fromDictionary:dict];
            self.imgUrl = [self objectOrNilForKey:kUserIDMediaImgUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.url forKey:kUserIDMediaUrl];
    [mutableDict setValue:self.imgUrl forKey:kUserIDMediaImgUrl];

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

    self.url = [aDecoder decodeObjectForKey:kUserIDMediaUrl];
    self.imgUrl = [aDecoder decodeObjectForKey:kUserIDMediaImgUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_url forKey:kUserIDMediaUrl];
    [aCoder encodeObject:_imgUrl forKey:kUserIDMediaImgUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserIDMedia *copy = [[UserIDMedia alloc] init];
    
    if (copy) {

        copy.url = [self.url copyWithZone:zone];
        copy.imgUrl = [self.imgUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
