//
//  dataInit.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/10.
//  Copyright (c) 2015年 emodel. All rights reserved.
//
import UIKit
import Foundation

let serverAddress: String! = "http://10.0.1.11"
//api.emwcn.com
var isLogin: Bool = false
var username: String!
var password: String!
var userId: String? = "55a7abda8a5da518db646c24"
//55a7abda8a5da518db646c18"
var token: String?
var baseInfo: BaseInfoRespData?
var bodyInfo: BodyInfoRespData?
var businessInfo: BusinessInfoRespData?

var album :Array<Album>! = Array<Album>()

/*
从default读取

*/

func readUserData() {
    let user = NSUserDefaults.standardUserDefaults()
    if let haveData: AnyObject = user.objectForKey("UserName") {
        println("have default for username")
        username = user.objectForKey("UserName") as? String
        password = (user.objectForKey("Password") as! String)
        userId = (user.objectForKey("UserID") as! String)
        println("read username: \(username)")
        println("read password \(password)")
        isLogin = true
    }
    else {
        println("no default data")
        isLogin = false
    }
}

