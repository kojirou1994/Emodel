//
//  Like.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/10.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

struct Like: JSONJoy {
    var count: Int?
    var isLiked: Bool?
    init(_ decoder: JSONDecoder) {
        count = decoder["count"].integer
        isLiked = decoder["isLiked"].bool
    }
}