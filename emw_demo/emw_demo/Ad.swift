//
//  Ad.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/26.
//  Copyright © 2015年 emodel. All rights reserved.
//


import Foundation

struct Ad: JSONJoy {
    var users: [String]?
    
    init(_ decoder: JSONDecoder) {
        if let data = decoder["data"]["26"].array {
            users = [String]()
            print(data)
            for user in data {
                if let id = user["modelId"].string {
                    users?.append(id)
                }
            }
        }
    }

}