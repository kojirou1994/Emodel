//
//  BodyInfo.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

//
//BodyInfo GET

struct BodyInfo: JSONJoy {
    
    ///血型
    var bloodType: String?
    ///身高
    var height: String?
    ///体重
    var weight: String?
    ///胸围
    var bust: Int?
    ///腰围
    var waist: Int?
    ///臀围
    var hip: Int?
    ///罩杯
    var cupSize: String?
    ///简介
    var introduction: String?
    ///服务
    var service: String?
    ///衣服尺寸
    var clothesSize: String?
    ///鞋子尺寸
    var shoesSize: String?
    ///裤子尺寸
    var trousersSize: String?
    
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
