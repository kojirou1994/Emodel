//
//  ModelCard.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import JSONJoy

//ModelCard GET
struct ModeCardResp: JSONJoy {
    var data: ModeCardRespData?
    var message: String?
    var status: Int?
    
    init(_ decoder: JSONDecoder) {
        data = ModeCardRespData(decoder["data"])
        message = decoder["message"].string
        status = decoder["status"].integer
    }
}

struct ModeCardRespData: JSONJoy {
    var imgUri: String?
    var isChecked: String?
    
    init(_ decoder: JSONDecoder) {
        imgUri = decoder["modelCardUri"].string
        isChecked = decoder["isChecked"].string
    }
}