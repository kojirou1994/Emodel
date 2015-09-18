//
//  AlbumInfo.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

//AlbumInfo GET 参数userid

struct Album: JSONJoy {
    //    var date: String?
    var id: String? = ""//相册ID获取照片列表
    var imgId: String? = ""
    var imgUri: String? = ""//相册封面
    var name: String? = "name"
    var num: Int? = 0
    var updateTime: String? = ""
    var userId: String? = ""
    
    init(){}
    init(_ decoder: JSONDecoder) {
        //        date = decoder["created_at"].string
        id = decoder["id"].string
        imgId = decoder["imgId"].string
        imgUri = decoder["imgUri"].string! + "?imageMogr2/thumbnail/!250x250r/gravity/North/crop/250x250"
        name = decoder["name"].string
        num = decoder["num"].integer
        updateTime = decoder["updated_at"].string
        userId = decoder["userId"].string
    }
    
}

struct AlbumInfoResp: JSONJoy {
    var data: Array<Album>?
    var status: Int?
    
    init(){}
    init(_ decoder: JSONDecoder) {
        status = decoder["status"].integer
        if let alb = decoder["data"].array {
            data = Array<Album>()
            for albumDecoder in alb {
                data?.append(Album(albumDecoder))
            }
        }
    }
}