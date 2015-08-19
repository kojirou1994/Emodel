//
//  JSONInfoStruct.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/4.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import JSONJoy


/*

struct : JSONJoy {
init(_ decoder: JSONDecoder) {
}
}

*/

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



//注册 SignUP POST
struct SignupResp: JSONJoy {
    var data: SignupRespData?
    var message: String?
    var status: Int?
    
    init(_ decoder: JSONDecoder) {
        data = SignupRespData(decoder["data"])
        message = decoder["message"].string
        status = decoder["status"].integer
    }
}

struct SignupRespData: JSONJoy {
    var token: String?
    init(_ decoder: JSONDecoder) {
        token = decoder["token"].string
    }
}




