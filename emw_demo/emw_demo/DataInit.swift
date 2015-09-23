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
///未读消息计数
var unreadCount: Int! = 0
///当前聊天用户id
var currentChatUserId: String?

var recentChatList: NSMutableDictionary!
let recentChatPlist = NSBundle.mainBundle().pathForResource("recentChatList", ofType: ".plist")

var unReadCount: Dictionary<String, Int>!

//var album :Array<Album>! = Array<Album>()

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
            unReadCount = count as? Dictionary
        }
        recentChatList = NSMutableDictionary(contentsOfFile: recentChatPlist!)
        print("read username: \(username)")
        print("read password \(password)")
        isLogin = true
    }
    else {
        print("no default data")
        isLogin = false
    }
}

public extension UIViewController {
    ///简单的通知框，两条信息
    public func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let actionYes = UIAlertAction(title: "返回", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(actionYes)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}