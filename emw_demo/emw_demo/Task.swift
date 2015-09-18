//
//  Task.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/10.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import Foundation

struct Task: JSONJoy {
    var address: String?
    var created_at: String?
    var deadLine: String?
    var id: String?
    var imgUri: String?
    var isAllowed: Bool = true
    var modelDemand: String?
    var otherDemand: String?
    var participant: [String] = [String]()
    var price: String?
    var remaining: Int?
    var title: String?
    var updated_at: String?
    var userId: String?
    var userTypeId: [Int]? = [Int]()
    var workTime: String?
    var workType: String?
    //需要人数
    var workersCount: Int?
    init(_ decoder: JSONDecoder) {
        address = decoder["address"].string
        created_at = decoder["created_at"].string
        deadLine = decoder["deadLine"].string
        id = decoder["id"].string
        imgUri = decoder["imgUri"].string
        if let allowed = decoder["isAllowed"].string {
            isAllowed = (allowed == "True")
        }
        modelDemand = decoder["modelDemand"].string
        otherDemand = decoder["otherDemand"].string
        if let arr = decoder["participant"].array {
            for i in arr {
                participant.append(i.string!)
            }
        }
        price = decoder["price"].string
        remaining = decoder["remaining"].integer
        title = decoder["title"].string
        updated_at = decoder["updated_at"].string
        userId = decoder["userId"].string
        if let arr = decoder["userTypeId"].array {
            for i in arr {
                userTypeId?.append(i.integer!)
            }
        }
        workTime = decoder["workTime"].string
        workType = decoder["workType"].string
        workersCount = decoder["workersCount"].integer
        
    }
    
    func userHaveSignedUp(inputID: String) -> Bool {
        for user in self.participant {
            if (user == inputID) {
                return true
            }
        }
        return false
    }
}

struct TaskResp: JSONJoy {
    var data: [Task]?
    var status: Int?
    init(_ decoder: JSONDecoder) {
        status = decoder["status"].integer
        if let arr = decoder["data"].array {
            data = [Task]()
            for i in arr {
                data?.append(Task(i))
            }
        }
    }
}