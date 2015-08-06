//
//  EMWBusinessInfo.h
//  e-Model
//
//  Created by 魏众 on 15/8/6.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMWBusinessInfo : NSObject
@property (nonatomic,assign)NSInteger dayPrice;
@property (nonatomic,assign)NSInteger inPrice;
@property (nonatomic,assign)NSInteger outPrice;
@property (nonatomic,assign)NSInteger startCount;
@property (nonatomic,assign)NSInteger underwearPrice;
- (id)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)businessInfoWithDictionary:(NSDictionary *)dict;
@end
