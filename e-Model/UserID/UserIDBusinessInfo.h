//
//  UserIDBusinessInfo.h
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserIDBusinessInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double dayPrice;
@property (nonatomic, assign) double startCount;
@property (nonatomic, assign) double inPrice;
@property (nonatomic, assign) double underwearPrice;
@property (nonatomic, assign) double outPrice;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
