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
struct BodyInfoResp: JSONJoy {
    var data: BodyInfoRespData?
    var message: String?
    var status: Int?
    
    init(_ decoder: JSONDecoder) {
        data = BodyInfoRespData(decoder["data"])
        message = decoder["message"].string
        status = decoder["status"].integer
    }
}

struct BodyInfoRespData: JSONJoy {
    
    var bloodType: String?//血型
    var height: Int?//身高
    var weight: Int?//体重
    var bust: Int?//胸围
    var waist: Int?//腰围
    var hip: Int?//臀围
    var cupSize: String?//罩杯
    var introduction: String?//简介
    var service: String?//服务
    var clothesSize: String?//衣服尺寸
    var shoesSize: Int?//鞋子尺寸
    var trousersSize: String?//裤子尺寸
    
    init(){}
    
    init(_ decoder: JSONDecoder) {
        bloodType = decoder["bloodType"].string
        bust = decoder["bust"].integer
        clothesSize = decoder["clothesSize"].string
        cupSize = decoder["cup"].string
        height = decoder["height"].integer
        hip = decoder["hips"].integer
        introduction = decoder["introduction"].string
        service = decoder["service"].string
        shoesSize = decoder["shoeSize"].integer
        trousersSize = decoder["trousers"].string
        waist = decoder["waistline"].integer
        weight = decoder["weight"].integer
    }
}
