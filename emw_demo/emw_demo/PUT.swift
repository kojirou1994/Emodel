//
//  PUT.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import JSONJoy

//PUT 更新信息结果

struct PutResp: JSONJoy {
    var status: Int?
    var message: String?
    
    init(_ decoder: JSONDecoder) {
        status = decoder["status"].integer
        message = decoder["message"].string
    }
}