//
//  EMWUser.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/10.
//  Copyright © 2015年 emodel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EMWUser {
    var userId: String?
    var token: String?
    internal var data: UserData?
    internal var isOnline: Bool {
        get {
            return true
        }}
    
    init(id: String) {
        self.userId = id
    }
    
    init(username: String, password: String) {
//        Alamofire.request(request(.POST, serverAddress + "/user/login", parameters: ["username": username, "password": password,"autoLogin": "1"], encoding: .JSON, headers: nil)
//        .validate()
//        .responseJSON(completionHandler: { (_, _, result) -> Void in
//            switch result {
//            case .Success:
////                JSON(result.value!)["token"]
//                print("ok")
//            case .Failure(_, let err):
//                print(err)
//            }
//        })
        
    }
    
    convenience init() {
        self.init(id: "guest")
    }
    func login() {
        
    }
    func registerYunbaAlias(ifOK successHandler:()-> Void, ifFail failHandler: ()->Void, reTry time: Int) {
        YunBaService.setAlias(self.userId) { (succ, _) -> Void in
            if (succ) {
                successHandler()
            }
            else {
                if (time > 1) {
                    self.registerYunbaAlias(ifOK: successHandler, ifFail: failHandler, reTry: time - 1)
                }
                else {
                    failHandler()
                }
            }
        }
    }
    
    func subscribeYunbaTopic(topic: String) {
        YunBaService.subscribe(topic) { (succ, _) -> Void in
            if (succ) {
                
            }
            else {
                self.subscribeYunbaTopic(topic)
            }
        }
    }
    
    func updateUserInfo(completionHandler: ()->Void, failedHandler: ()->Void) {
        guard let tokenGot = self.token else {
            Alamofire.request(.GET, serverAddress + "/user/\(self.userId)")
                .validate()
                .responseJSON { _, _, result in
                    switch result {
                    case .Success:
                        self.data = User(JSONDecoder(result.value!)).data
                    case .Failure(_, let error):
                        print(error)
                        dispatch_async(dispatch_get_main_queue(), {
                            failedHandler()
                        })
                        return
                    }
            }
            return
        }
        var getUserInfo: Bool?
        var getBaseInfo: Bool?
        
        //获取user信息
        Alamofire.request(.GET, serverAddress + "/user/\(self.userId)")
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    let resp = User(JSONDecoder(result.value!))
                    getUserInfo = true
                    guard let getAnother = getBaseInfo else {
                        localUser = resp.data
                        return
                    }
                    if (getAnother) {
                        let temp = localUser.baseInfo
                        localUser = resp.data
                        localUser.baseInfo = temp
                        print("从user进入")
                        dispatch_async(dispatch_get_main_queue(), {
                            completionHandler()
                        })
                    }
                    else {
                        dispatch_async(dispatch_get_main_queue(), {
                            failedHandler()
                        })
                    }
                case .Failure(_, let error):
                    print(error)
                    dispatch_async(dispatch_get_main_queue(), {
                        failedHandler()
                    })
                    return
                }
        }
        
        // baseinfo额外获取一次
        Alamofire.request(.GET, serverAddress + "/user/\(self.userId)/baseinfo", parameters: nil, encoding: ParameterEncoding.URL, headers: ["Token": tokenGot])
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    let resp = BaseInfoResp(JSONDecoder(result.value!))
                    getBaseInfo = true
                    guard let getAnother = getUserInfo else {
                        localUser.baseInfo = resp.data
                        return
                    }
                    if (getAnother) {
                        localUser.baseInfo = resp.data
                        print("从base进入")
                        dispatch_async(dispatch_get_main_queue(), {
                            completionHandler()
                        })
                    }
                    else {
                        dispatch_async(dispatch_get_main_queue(), {
                            failedHandler()
                        })
                    }
                case .Failure(_, let error):
                    print(error)
                    dispatch_async(dispatch_get_main_queue(), {
                        failedHandler()
                    })
                    return
                }
        }
    }
    
}

class hiu: JSONJoy {
    required init(_ decoder: JSONDecoder) {
        
    }
}