//
//  Chat.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/20.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox

extension AppDelegate: UITabBarDelegate {

    func setupChatService() {
        //定时检查是否在线
        registerYunbaAlias()
        subscribeYBTopic()
        addNotificationHandler()
        updateTabBarBadge()
        _ = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "updateOnlineState", userInfo: nil, repeats: true)
    }
    
    func addNotificationHandler() {
        let defaultNC = NSNotificationCenter.defaultCenter()
        defaultNC.addObserver(self, selector: "onMessageReceived:", name: kYBDidReceiveMessageNotification, object: nil)
        defaultNC.addObserver(self, selector: "onPresenceReceived:", name: kYBDidReceivePresenceNotification, object: nil)
    }
    func removeNotificationHandler() {
        let defaultNC = NSNotificationCenter.defaultCenter()
        defaultNC.removeObserver(self)
    }
    func updateOnlineState() {
        YunBaService.getAlias { (result, err) -> Void in
            if (result == nil) {
                //                print(err.localizedDescription)
                print("offline")
                isOnline = false
            }
            else {
                print("online in delegate")
                isOnline = true
                print(result)
            }
            NSNotificationCenter.defaultCenter().postNotificationName("AliasStateChanged", object: self)
        }
        
    }
    
    func updateTabBarBadge() {
        guard let tabbar = self.window?.rootViewController as? UITabBarController else {
            return
        }
        if (unReadCount["total"] > 0) {
            tabbar.viewControllers![1].tabBarItem.badgeValue = String(unReadCount["total"]!)
        }
        else {
            tabbar.viewControllers![1].tabBarItem.badgeValue = nil

        }
    }
    
    func onMessageReceived(notification: NSNotification) {
        AudioServicesPlaySystemSound(1007)
        let receiveTime = NSDate()
        let message: YBMessage = notification.object as! YBMessage
        print("new message \(message.data.length) bytes, topic = \(message.topic)")
        let payloadString = NSString(data: message.data, encoding: NSUTF8StringEncoding)
        print("data: \(payloadString)")
        if (message.topic == "iOS") {
            print("是广播")
            //是广播
        }
        else {
            let receivedMessage = YunbaChatMessage(JSONDecoder(message.data))
            if (receivedMessage.fromUserId == "000000") {
                //error
                print("error 000000")
            }
            else if (receivedMessage.fromUserId != currentChatUserId || currentChatUserId == nil) {
                //获取到的信息不是当前正在聊天的用户，更新角标
                print("获取到的信息不是当前正在聊天的用户，更新角标")
                if (unReadCount["\(receivedMessage.fromUserId)"] == nil) {
                    unReadCount["\(receivedMessage.fromUserId)"] = 1
                    unReadCount["total"] = unReadCount["total"]! + 1
                }
                else {
                    unReadCount["\(receivedMessage.fromUserId)"] = unReadCount["\(receivedMessage.fromUserId)"]! + 1
                    unReadCount["total"] = unReadCount["total"]! + 1
                }
                
                recentChatList[receivedMessage.fromUserId] = ["time": receiveTime,
                    "message": receivedMessage.messageContent
                ]
                
                DataManager.saveMessageToDatabase(userId, remoteUserId: receivedMessage.fromUserId, messageType: receivedMessage.messageType, isFromSelf: false, time: receiveTime, messageContent: receivedMessage.messageContent)
            }
            else {
                //获取到的信息是当前正在聊天的用户，只保存
                print("获取到的信息是当前正在聊天的用户，只保存")
                recentChatList[receivedMessage.fromUserId] = ["time": receiveTime,
                    "message": receivedMessage.messageContent
                ]
                
                DataManager.saveMessageToDatabase(userId, remoteUserId: receivedMessage.fromUserId, messageType: receivedMessage.messageType, isFromSelf: false, time: receiveTime, messageContent: receivedMessage.messageContent)
            }
        }
        print("接受消息后的recentChatList")
        print(recentChatList)
        recentChatList.writeToFile(recentChatPlist, atomically: true)
        NSNotificationCenter.defaultCenter().postNotificationName("updateChatListVC", object: self)
        NSUserDefaults.standardUserDefaults().setObject(unReadCount, forKey: "UnreadCount")
        updateTabBarBadge()
    }
    
    func onPresenceReceived(notification: NSNotification) {
        let presence: YBPresenceEvent = notification.object as! YBPresenceEvent
        print("new presence, action = \(presence.action), topic = \(presence.topic), alias = \(presence.alias), time = \(presence.time)")
    }
}