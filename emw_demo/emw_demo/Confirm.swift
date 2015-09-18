//
//  Confirm.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/2.
//  Copyright (c) 2015年 emodel. All rights reserved.
//
//手机验证码 Confirm POST
struct ConfirmResp: JSONJoy {
    var data: ConfirmRespData?
    var message: String?
    var status: Int?
    init(_ decoder: JSONDecoder) {
        data = ConfirmRespData(decoder["data"])
        message = decoder["message"].string
        status = decoder["status"].integer
    }
}

struct ConfirmRespData: JSONJoy {
    var confirm_token: String?
    init(_ decoder: JSONDecoder) {
        confirm_token = decoder["confirm_token"].string
    }
}