//
//  BusinessInfo.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import JSONJoy

//BusinessInfo GET
struct BusinessInfoResp: JSONJoy {
    var data: BusinessInfoRespData?
    var message: String?
    var status: Int?
    
    init(_ decoder: JSONDecoder) {
        data = BusinessInfoRespData(decoder["data"])
        message = decoder["message"].string
        status = decoder["status"].integer
    }
}

struct BusinessInfoRespData: JSONJoy {
    var dayPrice: Int?//包日价格
    var inPrice: Int?//内景价格
    var outPrice: Int?//外拍价格
    var startCount: Int?//起拍件数
    var underwearPrice: Int?//内衣价格
    
    init(){}
    init(_ decoder: JSONDecoder) {
        dayPrice = decoder["dayPrice"].integer
        inPrice = decoder["inPrice"].integer
        outPrice = decoder["outPrice"].integer
        startCount = decoder["startCount"].integer
        underwearPrice = decoder["underwearPrice"].integer
    }
}