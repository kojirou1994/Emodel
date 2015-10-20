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
    var date: NSDate?
    var schedule: [Schedule]?
    var timeBucket: String?
    
    init(_ decoder: JSONDecoder) {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        date = format.dateFromString(decoder["date"].string!)
        if let s = decoder["schedule"].array {
            schedule = [Schedule]()
            for item in s {
                schedule?.append(Schedule(item))
            }
        }
        timeBucket = decoder["timeBucket"].string
    }
}

struct Schedule: JSONJoy {
    var body: String?
    var title: String?
    var type: String?
    var timeBucket: TimeBucket
    init(_ decoder: JSONDecoder) {
        body = decoder["body"].string
        title = decoder["title"].string
        type = decoder["type"].string
        if let bucket = decoder["timeBucket"].integer {
            switch bucket {
            case 61440:
                timeBucket = .Morning
            case 3840:
                timeBucket = .Afternoon
            case 16777215:
                timeBucket = .Allday
            default:
                timeBucket = .Morning
            }
        }
        else {
            timeBucket = .Morning
        }
    }
}

enum TimeBucket: String {
    case Morning = "上午",Afternoon = "下午",Allday = "全天"
}