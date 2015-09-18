//
//  File.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//


//登录 Login POST
struct LoginResp: JSONJoy {
    var data: LoginRespData?
    var message: String?
    var status: Int?
    
    init(_ decoder: JSONDecoder) {
        data = LoginRespData(decoder["data"])
        message = decoder["message"].string
        status = decoder["status"].integer
    }
}

struct LoginRespData: JSONJoy {
    var token: String?
    var userId: String?
    
    init(_ decoder: JSONDecoder) {
        token = decoder["token"].string
        userId = decoder["userId"].string
    }
}