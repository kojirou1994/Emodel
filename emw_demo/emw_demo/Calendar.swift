//
//  Calendar.swift
//  EMWCalendar
//
//  Created by 王宇 on 15/8/21.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import Foundation
import JSONJoy

struct Calendar: JSONJoy {
    var status: Int?
    var message: String?
    var data: NSDictionary?
    
    var eventDate = NSDateFormatter()
    
    init(_ decoder: JSONDecoder) {
        eventDate.dateFormat = "yyyy-MM-dd"
        status = decoder["status"].integer
        message = decoder["message"].string
        data = decoder["data"].dictionary
    }
    
    func haveEventForDate(date: NSDate) -> Bool {
        if let res: AnyObject? = data!.objectForKey(eventDate.stringFromDate(date)) {
            return true
        }
        return true
    }
    
    func getScheduleForDate(date: NSDate) -> Schedule{
        var schedule = Schedule(JSONDecoder(data!.objectForKey(eventDate.stringFromDate(date))!))
        return schedule
    }
}

struct Schedule: JSONJoy {
    var event: Array<Event>?
    var count: Int = 0
    init(_ decoder: JSONDecoder) {
        if let eve = decoder["schedule"].array {
            event = Array<Event>()
            for i in eve {
                event?.append(Event(i))
            }
            count = eve.count
        }
    }
}

struct Event: JSONJoy {
    var body: String?
    var timeBucket: String?
    var title: String?
    var type: String?
    init(){}
    init(_ decoder: JSONDecoder) {
        body = decoder["body"].string
        timeBucket = decoder["timeBucket"].string
        title = decoder["title"].string
        type = decoder["type"].string
    }
    
}