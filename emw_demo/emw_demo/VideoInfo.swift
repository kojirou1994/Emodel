//
//  VideoInfo.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

//VideoInfo GET
struct VideoInfoResp: JSONJoy {
    var data: VideoInfoRespData?
    var message: String?
    var status: Int?
    
    init(_ decoder: JSONDecoder) {
        data = VideoInfoRespData(decoder["data"])
        message = decoder["message"].string
        status = decoder["status"].integer
    }
}

struct VideoInfoRespData: JSONJoy {
    var imgUri: String?
    var isChecked: String?
    var videoUri: String?
    
    init(_ decoder: JSONDecoder) {
        imgUri = decoder["imgUri"].string
        isChecked = decoder["isChecked"].string
        videoUri = decoder["mediaUri"].string
    }
}