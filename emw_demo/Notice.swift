//
//  Notice.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class Notice: NSObject {
    let title: String
    let thumbnails: String
    let status: String
    let time: String
    let price: String
    let location: String
    init(title: String, thumbnails: String, status: String, time: String, price: String, location: String) {
        self.title = title
        self.thumbnails = thumbnails
        self.status = status
        self.time = time
        self.price = price
        self.location = location
    }
}
