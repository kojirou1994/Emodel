//
//  Task.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/10.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import Foundation
import JSONJoy

struct Task: JSONJoy {
    var address: String?
    var created_at: String?
    var deadLine: String?
    var id: String?
    var imgUri: String?
    var isAllowed: Bool = true
    var modelDemand: String?
    var otherDemand: String?
    var participant: [String]? = [String]()
    var price: String?
    var remaining: Int?
    var title: String?
    var updated_at: String?
    var userId: String?
    var userTypeId: [Int]? = [Int]()
    var workTime: String?
    var workType: String?
    //需要人数
    var workersCount: Int?
    init(_ decoder: JSONDecoder) {
        address = decoder["address"].string
        created_at = decoder["created_at"].string
        deadLine = decoder["deadLine"].string
        id = decoder["id"].string
        imgUri = decoder["imgUri"].string
        if let allowed = decoder["isAllowed"].string {
            isAllowed = (allowed == "true")
        }
        modelDemand = decoder["modelDemand"].string
        otherDemand = decoder["otherDemand"].string
        if let arr = decoder["participant"].array {
            for i in arr {
                participant?.append(i.string!)
            }
        }
        price = decoder["price"].string
        remaining = decoder["remaining"].integer
        title = decoder["title"].string
        updated_at = decoder["updated_at"].string
        userId = decoder["userId"].string
        if let arr = decoder["userTypeId"].array {
            for i in arr {
                userTypeId?.append(i.integer!)
            }
        }
        workTime = decoder["workTime"].string
        workType = decoder["workType"].string
        
    }
}
/*
"address": "\u676d\u5dde",
"created_at": "2015-09-07",
"deadLine": "2015-09-20",
"id": "2015090708152743",
"imgUri": "http://cdn.photo.emwcn.com/20150907144742557936.jpg",
"isAllowed": "True",
"modelDemand": "170\u4ee5\u4e0a\uff0c\u6027\u611f\u6f02\u4eae\uff0c\u62cd\u6444\u4e92\u514d\uff0c\u6709\u7ecf\u9a8c\u4f18\u5148\u3002",
"otherDemand": "\u4e0d\u7b26\u52ff\u6270",
"participant": null,
"price": "\u4e92\u514d",
"remaining": 9,
"title": "\u8dd1\u8f66\u5f62\u8c61\u521b\u4f5c\u62cd\u6444\u9700\u8981\u6bd4\u57fa\u5c3c\u7f8e\u5973",
"updated_at": "2015-09-07",
"userId": "55cd629929b06f412b19e5c9",
"userTypeId": [
1
],
"workTime": "\u672c\u6708\u4e2d\u65ec",
"workType": "\u6bd4\u57fa\u5c3c\u62cd\u6444",
"workersCount": 1
*/