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

var isLogin: Bool = false
var username: String!
var password: String!
var userId: String!
var token: String!
var localUser: UserData!
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
    public func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let actionYes = UIAlertAction(title: "返回", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(actionYes)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}