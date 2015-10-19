//
//  MainTabBar.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/18.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox

class MainTabBar: UITabBarController {

    var chatListVC: ChatListViewController!
    var checkOnline: NSTimer!
    override func viewDidLoad() {
        print("start viewDidLoad")
        super.viewDidLoad()
        if (unReadCount["total"] > 0) {
            self.viewControllers![1].tabBarItem.badgeValue = String(unReadCount["total"]!)
        }
        else {
            self.viewControllers![1].tabBarItem.badgeValue = nil
        }
        self.addNotificationHandler()
//        updateTabBarApperance()
        registerYunbaAlias()

        checkOnline = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "updateState", userInfo: nil, repeats: true)
        print("viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        self.selectedViewController?.beginAppearanceTransition(true, animated: true)

//        self.updateTabBarApperance()
    }
    
    override func viewDidAppear(animated: Bool) {
        print("viewDidAppear")
        self.selectedViewController?.endAppearanceTransition()
    }
    override func viewWillDisappear(animated: Bool) {
        self.selectedViewController?.beginAppearanceTransition(false, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.selectedViewController?.endAppearanceTransition()
    }
    func updateState() {
        YunBaService.getAlias { (result, err) -> Void in
            if (result == nil) {
//                print(err.localizedDescription)
                print("offline")
                isOnline = false
            }
            else {
                print("online")
                isOnline = true
                print(result)
            }
            NSNotificationCenter.defaultCenter().postNotificationName("AliasStateChanged", object: self)
        }
    }

    //MARK : - YunbaService
    func addNotificationHandler() {
        let defaultNC = NSNotificationCenter.defaultCenter()
        defaultNC.addObserver(self, selector: "onMessageReceived:", name: kYBDidReceiveMessageNotification, object: nil)
        defaultNC.addObserver(self, selector: "onPresenceReceived:", name: kYBDidReceivePresenceNotification, object: nil)
    }
    func removeNotificationHandler() {
        let defaultNC = NSNotificationCenter.defaultCenter()
        defaultNC.removeObserver(self)
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
        updateTabBarApperance()
    }
    
    func onPresenceReceived(notification: NSNotification) {
        let presence: YBPresenceEvent = notification.object as! YBPresenceEvent
        print("new presence, action = \(presence.action), topic = \(presence.topic), alias = \(presence.alias), time = \(presence.time)")
    }
    
    func updateTabBarApperance() {
//        chatListVC = self.tabBarController?.viewControllers![1] as! ChatListViewController
        if (unReadCount["total"] > 0) {
            self.viewControllers![1].tabBarItem.badgeValue = String(unReadCount["total"]!)
        }
        else {
            self.viewControllers![1].tabBarItem.badgeValue = nil
        }
//        chatListVC.chatListTableView.reloadData()
    }
}




