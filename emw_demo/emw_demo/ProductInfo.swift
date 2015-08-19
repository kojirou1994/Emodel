//
//  ProductInfo.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import JSONJoy

//ProductInfo GET

/*
{
"data": {
"1": {
"created_at": "2015-05-06 14:39:10",
"id": 1,
"name": "\u670d\u9970",
"pid": 0,
"updated_at": "2015-05-06 14:39:10"
},
"3": {
"created_at": "2015-05-06 14:39:10",
"id": 3,
"name": "\u978b\u5e3d",
"pid": 0,
"updated_at": "2015-05-06 14:39:10"
},
"4": {
"created_at": "2015-05-06 14:39:10",
"id": 4,
"name": "\u62a4\u80a4",
"pid": 0,
"updated_at": "2015-05-06 14:39:10"
},
"5": {
"created_at": "2015-05-06 14:39:10",
"id": 5,
"name": "\u4f69\u9970",
"pid": 0,
"updated_at": "2015-05-06 14:39:10"
}
},
"message": "success",
"status": 200
}
*/
struct ProductResp: JSONJoy {
    var data: ProductData?
    var status: Int?
    
    init(_ decoder: JSONDecoder) {
        data = ProductData(decoder["data"])
        status = decoder["status"].integer
    }
}
struct ProductData: JSONJoy {
    var one: ProductCell?
    var two: ProductCell?
    var three: ProductCell?
    var four: ProductCell?
    var five: ProductCell?
    
    init(_ decoder: JSONDecoder) {
        one = ProductCell(decoder["1"])
        two = ProductCell(decoder["2"])
        three = ProductCell(decoder["3"])
        four = ProductCell(decoder["4"])
        five = ProductCell(decoder["5"])
    }
}

struct ProductCell: JSONJoy {
    var createTime: String?//
    var id: Int = 0//
    var name: String?//
    var pid: Int?//
    var updateTime: String?//
    init(_ decoder: JSONDecoder) {
        createTime = decoder["createTime"].string
        id = decoder["id"].integer!
        name = decoder["name"].string
        pid = decoder["pid"].integer
        updateTime = decoder["updateTime"].string
    }
}
