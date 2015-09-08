//
//  Calendar.swift
//  EMWCalendar
//
//  Created by 王宇 on 15/8/21.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import Foundation
import JSONJoy

struct CalendarResp: JSONJoy {
    var status: Int?
    var message: String?
    var data: [Calendar]?

    init(_ decoder: JSONDecoder) {
        status = decoder["status"].integer
        message = decoder["message"].string
        if let cal = decoder["data"].array {
            data = Array<Calendar>()
            for item in cal {
                data?.append(Calendar(item))
            }
        }
    }
    
}

struct Calendar: JSONJoy {
    var date: String!
    var schedule: Schedule!
    var timeBucket: String!
    init(_ decoder: JSONDecoder) {
        date = decoder["date"].string
        schedule = Schedule(decoder["schedule"])
        
    }
}

struct Schedule: JSONJoy {
    var body: String!
    var title: String!
    var type: String!
    init(_ decoder: JSONDecoder) {
        body = decoder["body"].string
        title = decoder["title"].string
        type = decoder["type"].string
    }
}