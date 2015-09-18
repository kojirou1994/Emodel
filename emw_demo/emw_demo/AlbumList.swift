//
//  AlbumList.swift
//  emwAlbum
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//


//单个相册里的照片数据列表
struct AlbumListData: JSONJoy {
    var albumId: String? = "000000000000000000000000"
    var created_at: String? = "Mon, 10 Jul 2015 00:00:00 -0000"
    var id: String? = "000000000000000000000000"
    var imgUri: String! = "example.jpg"
    var thumbUri:String? = "example.jpg"
    var userId: String? = "000000000000000000000000"
    
    init(){}
    init(_ decoder: JSONDecoder) {
        created_at = decoder["created_at"].string
        id = decoder["id"].string
        imgUri = decoder["imgUri"].string
        albumId = decoder["albumId"].string
        userId = decoder["userId"].string
        thumbUri = imgUri! + "?imageMogr2/thumbnail/!250x250r/gravity/North/crop/250x250"
//        "?imageView2/0/h/200"
    }
}

struct AlbumList: JSONJoy {
    var data: Array<AlbumListData>? = Array<AlbumListData>()
    var status: Int?
    
    init(){}
    init(_ decoder: JSONDecoder) {
        status = decoder["status"].integer
        if let alb = decoder["data"].array {
            for albumDecoder in alb {
                data?.append(AlbumListData(albumDecoder))
            }
        }
    }
}