//
//  OrderData.h
//
//  Created by 众 魏 on 15/8/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OrderData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) id orderDate;
@property (nonatomic, strong) id style;
@property (nonatomic, strong) id dataIdentifier;
@property (nonatomic, strong) id timeBucket;
@property (nonatomic, strong) id note;
@property (nonatomic, strong) id contact;
@property (nonatomic, strong) id createdAt;
@property (nonatomic, strong) id mobile;
@property (nonatomic, strong) id product;
@property (nonatomic, strong) id isAgree;
@property (nonatomic, strong) id address;
@property (nonatomic, assign) double num;
@property (nonatomic, strong) id modelId;
@property (nonatomic, strong) id isComplete;
@property (nonatomic, strong) id companyId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
