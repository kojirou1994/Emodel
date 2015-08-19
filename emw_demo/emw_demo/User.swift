//
//  User.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/19.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class User: NSObject {
    var username: String = "guest"
    var password: String
    var baseinfo: BaseInfoRespData?
    
    init(username: String, password: String){
        self.username = username
        self.password = password
    }
    
    func updateUserInformation() {
        
    }
    
}
