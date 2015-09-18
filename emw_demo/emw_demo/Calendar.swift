//
//  Calendar.swift
//  EMWCalendar
//
//  Created by 王宇 on 15/8/21.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

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
    var date: String?
    var schedule: Schedule?
    var timeBucket: Int!
    var isMorning: Bool! = false
    var isAfternoon: Bool! = false
    var isNight: Bool! = false
    init(_ decoder: JSONDecoder) {
        date = decoder["date"].string
        schedule = Schedule(decoder["schedule"])
        timeBucket = decoder["timeBucket"].integer
        var time = String(timeBucket)
        var count = 0
        for cha in time.characters {
            if (count == 4) {
                if (cha == "0") {
                    isMorning = false
                }
                else {
                    isMorning = true
                }
            }
            else if (count == 5) {
                if (cha == "0") {
                    isAfternoon = false
                }
                else {
                    isAfternoon = true
                }
            }
            else if (count == 6) {
                if (cha == "0") {
                    isNight = false
                }
                else {
                    isNight = true
                }
            }
            count++
        }
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