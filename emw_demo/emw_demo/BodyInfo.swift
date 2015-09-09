//
//  BodyInfo.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import JSONJoy

//
//BodyInfo GET

struct BodyInfo: JSONJoy {
    
    var bloodType: String?//血型
    var height: String?//身高
    var weight: String?//体重
    var bust: Int?//胸围
    var waist: Int?//腰围
    var hip: Int?//臀围
    var cupSize: String?//罩杯
    var introduction: String?//简介
    var service: String?//服务
    var clothesSize: String?//衣服尺寸
    var shoesSize: String?//鞋子尺寸
    var trousersSize: String?//裤子尺寸
    
    init(){}
    
    init(_ decoder: JSONDecoder) {
        bloodType = decoder["bloodType"].string
        bust = decoder["bust"].integer
        clothesSize = decoder["clothesSize"].string
        cupSize = decoder["cup"].string
        height = decoder["height"].string
        hip = decoder["hips"].integer
        introduction = decoder["introduction"].string
        service = decoder["service"].string
        shoesSize = decoder["shoeSize"].string
        trousersSize = decoder["trousers"].string
        waist = decoder["waistline"].integer
        weight = decoder["weight"].string
    }
}
