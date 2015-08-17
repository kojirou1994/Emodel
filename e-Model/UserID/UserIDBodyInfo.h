//
//  UserIDBodyInfo.h
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserIDBodyInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *waist;
@property (nonatomic, strong) NSString *shoeSize;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *clothesSize;
@property (nonatomic, strong) NSString *trousers;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *bloodType;
@property (nonatomic, assign) double waistline;
@property (nonatomic, assign) double bust;
@property (nonatomic, strong) NSString *service;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, assign) double hips;
@property (nonatomic, strong) NSString *cup;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
