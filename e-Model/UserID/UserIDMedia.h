//
//  UserIDMedia.h
//
//  Created by 众 魏 on 15/8/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserIDMedia : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) id url;
@property (nonatomic, assign) id imgUrl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
