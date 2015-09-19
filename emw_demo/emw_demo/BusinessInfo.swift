//
//  BusinessInfo.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

//BusinessInfo GET

struct BusinessInfo: JSONJoy {
    ///包日价格
    var dayPrice: Int?
    ///内景价格
    var inPrice: Int?
    ///外拍价格
    var outPrice: Int?
    ///起拍件数
    var startCount: Int?
    ///内衣价格
    var underwearPrice: Int?
    
    init(){}
    init(_ decoder: JSONDecoder) {
        dayPrice = decoder["dayPrice"].integer
        inPrice = decoder["inPrice"].integer
        outPrice = decoder["outPrice"].integer
        startCount = decoder["startCount"].integer
        underwearPrice = decoder["underwearPrice"].integer
    }
}