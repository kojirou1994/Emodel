//
//  User.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/19.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

struct User: JSONJoy {
    var data: UserData?
    var status: Int?
    var message: String?
    init(_ decoder: JSONDecoder) {
        data = UserData(decoder["data"])
        status = decoder["status"].integer
        message = decoder["message"].string
    }
}

struct UserData: JSONJoy {
    var albumInfo: Array<Album>?
    var baseInfo: BaseInfo?
    var bodyInfo: BodyInfo?
    var businessInfo: BusinessInfo?
    var like: Like?
    var calendar: Array<Calendar>?
    var cityID: Int?
    var userID: String?
    var star: Int! = 0
    var viewCount: Int?
    init(){}
    init(_ decoder: JSONDecoder) {
        cityID = decoder["cityId"].integer
        userID = decoder["id"].string
        viewCount = decoder["viewCount"].integer
        if let rank = decoder["star"].integer {
            star = rank
        }
        else {
            star = 0
        }
        if let alb = decoder["albuminfo"].array {
            albumInfo = Array<Album>()
            for albumDecoder in alb {
                albumInfo?.append(Album(albumDecoder))
            }
        }
        if let cal = decoder["calendar"].array {
            calendar = Array<Calendar>()
            for item in cal {
                calendar?.append(Calendar(item))
            }
        }
        baseInfo = BaseInfo(decoder["baseinfo"])
        bodyInfo = BodyInfo(decoder["bodyinfo"])
        businessInfo = BusinessInfo(decoder["businessinfo"])
        like = Like(decoder["like"])
        
    }
    
    func updateUserInformation() {
        
    }
    
}


enum UserType: Int {
    case Guest = 0,Modal = 1,Company = 2
}
