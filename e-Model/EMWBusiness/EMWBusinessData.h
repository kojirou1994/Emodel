//
//  EMWBusinessData.h
//
//  Created by 众 魏 on 15/8/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EMWBusinessData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double outPrice;
@property (nonatomic, assign) double underwearPrice;
@property (nonatomic, assign) double inPrice;
@property (nonatomic, assign) double dayPrice;
@property (nonatomic, assign) double startCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
