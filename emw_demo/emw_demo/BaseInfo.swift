//
//  BaseInfo.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import JSONJoy

//基本信息 BaseInfo GET

struct BaseInfo: JSONJoy {
    var QQ: String? = "10000"
    var age: Int? = 0
    var avatar: String?  = ""//头像
    var birthday: String?
    var email: String? = "example@email.com"
    var introduction: String?
    var mobile: String?
    var nickName: String?
    var realName: String?
    var service: String?
    var sex: String?//性别
    var wechat: String?
    
    init(){}
    
    init(_ decoder: JSONDecoder) {
        QQ = decoder["QQ"].string
        age = decoder["age"].integer
        avatar = decoder["avatar"].string
        birthday = decoder["birthday"].string
        email = decoder["email"].string
        introduction = decoder["introduction"].string
        mobile = decoder["mobile"].string
        nickName = decoder["nickName"].string
        realName = decoder["realName"].string
        service = decoder["service"].string
        sex = decoder["sex"].string
        wechat = decoder["wechat"].string
    }
}

struct BaseInfoResp: JSONJoy {
    var status: Int?
    var data: BaseInfo?
    init(_ decoder: JSONDecoder) {
        status = decoder["status"].integer
        data = BaseInfo(decoder["data"])
    }
}