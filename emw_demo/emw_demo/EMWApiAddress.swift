//
//  EMWApiAddress.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/10.
//  Copyright © 2015年 emodel. All rights reserved.
//

import Foundation
public class EMWApiAddress {
    var serverAddress: String
    init() {
        serverAddress = publicServer
    }
    public func duplication() -> String {
        return serverAddress + "/user/duplication"
    }
}