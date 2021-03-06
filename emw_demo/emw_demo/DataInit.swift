//
//  dataInit.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/10.
//  Copyright (c) 2015年 emodel. All rights reserved.
//
import UIKit
import Foundation

//MARK: - 全局变量
let testServer: String! = "http://10.0.1.11"
let publicServer: String! = "http://api.emwcn.com"

let serverAddress: String! = publicServer
///用户是否已登录
var isLogin: Bool = false
var isOnline: Bool = false
///本地用户名
var username: String!
///本地用户密码
var password: String!
///本地用户userID
var userId: String!
///本地用户token
var token: String!
///本地用户资料
var localUser: UserData!
///用户类型
var userType: UserType!
///当前聊天用户id
var currentChatUserId: String?

var recentChatList: NSMutableDictionary!
let recentChatPlist = ((NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents") as NSString).stringByAppendingPathComponent("recentChatList.plist")

var unReadCount: Dictionary<String, Int>!

var chatListVCLoaded: Bool = false


//MARK: - 初始化

func readUserData() {
    let user = NSUserDefaults.standardUserDefaults()
    if let _: AnyObject = user.objectForKey("UserName") {
        print("have default for username")
        username = user.objectForKey("UserName") as? String
        password = (user.objectForKey("Password") as! String)
        userId = (user.objectForKey("UserID") as! String)
        token = user.objectForKey("Token") as! String
        if let count = user.objectForKey("UnreadCount") as? NSDictionary {
            unReadCount = count as! Dictionary
        }
        else {
            unReadCount = ["total": 0]
        }

        let fm = NSFileManager.defaultManager()
        if (fm.fileExistsAtPath(recentChatPlist)) {
            recentChatList = NSMutableDictionary(contentsOfFile: recentChatPlist)
        }
        else {
            recentChatList = NSMutableDictionary()
        }
        if let type = user.objectForKey("UserType") as? Int {
            switch type {
            case 0:
                userType = .Guest
            case 1:
                userType = .Modal
            case 2:
                userType = .Company
            default:
                userType = .Modal
            }
        }
        else {
            userType = .Modal
        }
        user.setObject(userType.rawValue, forKey: "UserType")
        isLogin = true
    }
    else {
        isLogin = false
    }
}


func registerYunbaAlias() {
    YunBaService.setAlias(userId, resultBlock: { (succ: Bool, error: NSError!) -> Void in
        if (succ) {
            print("注册用户名成功")
            isOnline = true
        }
        else {
            print("注册用户名失败,重试")
            isOnline = false
            registerYunbaAlias()
        }
        NSNotificationCenter.defaultCenter().postNotificationName("AliasStateChanged", object: nil)
    })
}
func subscribeYBTopic() {
    YunBaService.subscribe("iOS", resultBlock: { (succ: Bool, error: NSError!) -> Void in
        if (succ) {
            print("订阅成功")
        }
        else {
            subscribeYBTopic()
            print("订阅失败")
        }
    })
}

public extension UIViewController {
    ///简单的通知框，两条信息
    public func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "返回", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}