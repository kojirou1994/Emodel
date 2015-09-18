//
//  AlbumID.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/12.
//  Copyright (c) 2015年 emodel. All rights reserved.
//


//数组
struct SinglePhoto: JSONJoy {
    var created_at: String? = "Mon, 10 Jul 2015 00:00:00 -0000"
    var id: String? = "000000000000000000000000"
    var imgUri: String? = "example.jpg"
    var name: String? = "name"
    var updated__at: String? = "Mon, 10 Jul 2015 00:00:00 -0000"
    
    init(){}
    init(_ decoder: JSONDecoder) {
        created_at = decoder["created_at"].string
        id = decoder["id"].string
        imgUri = decoder["imgUri"].string
        name = decoder["name"].string
        updated__at = decoder["updated_at"].string
    }
}

struct AlbumID: JSONJoy {
    var data: Array<SinglePhoto>? = Array<SinglePhoto>()
    var status: Int?
    
    init(_ decoder: JSONDecoder) {
        status = decoder["status"].integer
        if let alb = decoder["data"].array {
            for albumDecoder in alb {
                data?.append(SinglePhoto(albumDecoder))
            }
        }
    }
}