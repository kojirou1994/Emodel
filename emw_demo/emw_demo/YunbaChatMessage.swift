//
//  YunbaChatMessage.swift
//  YunbaMessageJsonTest
//
//  Created by 王宇 on 15/9/19.
//  Copyright © 2015年 emodel. All rights reserved.
//

import Foundation
struct YunbaChatMessage: JSONJoy {
    var fromUserId:String! = "000000"
    ///type 0错误 1文字 2录音 3图片
    var messageType:Int! = 0
    var messageContent:String! = "消息获取失败"
    init(_ decoder: JSONDecoder) {
        guard let uid = decoder["fromUserId"].string else {
            return
        }
        guard let mType = decoder["messageType"].integer else {
            return
        }
        fromUserId = uid
        messageType = mType
        messageContent = ""
        if let mContent = decoder["messageContent"].string {
            messageContent = mContent
        }
    }
}