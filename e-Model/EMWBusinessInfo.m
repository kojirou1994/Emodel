//
//  EMWBusinessInfo.m
//  e-Model
//
//  Created by 魏众 on 15/8/6.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import "EMWBusinessInfo.h"

@implementation EMWBusinessInfo
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.dayPrice = [[dic objectForKey:@"dayPrice"]integerValue];
        self.inPrice = [[dic objectForKey:@"inPrice"]integerValue];
        self.outPrice = [[dic objectForKey:@"outPrice"]integerValue];
        self.startCount = [[dic objectForKey:@"startCount"]integerValue];
        self.underwearPrice = [[dic objectForKey:@"underwearPrice"]integerValue];
    }
    return self;
}
+ (instancetype)businessInfoWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
@end
