//
//  MainTabBar.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/18.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import CoreData

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        print("start viewDidLoad")
        super.viewDidLoad()
        self.addNotificationHandler()
        updateTabBarApperance()
        
        YunBaService.setAlias(userId, resultBlock: { (succ: Bool, error: NSError!) -> Void in
            if (succ) {
                print("注册用户名成功")
            }
            else {
                print("注册用户名失败")
            }
        })
        YunBaService.subscribe("iOS", resultBlock: { (succ: Bool, error: NSError!) -> Void in
            if (succ) {
                print("订阅成功")
            }
            else {
                print("订阅失败")
            }
        })
//        print("sleep 5s")
//        sleep(5)
        print("viewDidLoad")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewDidAppear(animated: Bool) {
        print("viewDidAppear")
    }


    //MARK : - YunbaService
    func addNotificationHandler() {
        let defaultNC = NSNotificationCenter.defaultCenter()
        defaultNC.addObserver(self, selector: "onMessageReceived:", name: kYBDidReceiveMessageNotification, object: nil)
        defaultNC.addObserver(self, selector: "onPresenceReceived", name: kYBDidReceivePresenceNotification, object: nil)
    }
    func removeNotificationHandler() {
        let defaultNC = NSNotificationCenter.defaultCenter()
        defaultNC.removeObserver(self)
    }
    
    func onMessageReceived(notification: NSNotification) {
        let message: YBMessage = notification.object as! YBMessage
        print("new message \(message.data.length) bytes, topic = \(message.topic)")
        let payloadString = NSString(data: message.data, encoding: NSUTF8StringEncoding)
        print("data: \(payloadString)")
        if (message.topic == "iOS") {
            //是广播
        }
        else if (currentChatUserId == nil || currentChatUserId != message.topic) {
            unreadCount = unreadCount + 1
            saveMessageToDatabase(userId, remoteUserId: message.topic, messageType: 1, isFromSelf: false, time: NSDate(), messageContent: YunbaChatMessage(JSONDecoder(message.data)).messageContent)
        }
        else {
            saveMessageToDatabase(userId, remoteUserId: message.topic, messageType: 1, isFromSelf: false, time: NSDate(), messageContent: YunbaChatMessage(JSONDecoder(message.data)).messageContent)
        }
        
        updateTabBarApperance()
    }
    
    func onPresenceReceived(notification: NSNotification) {
        let presence: YBPresenceEvent = notification.object as! YBPresenceEvent
        print("new presence, action = \(presence.action), topic = \(presence.topic), alias = \(presence.alias), time = \(presence.time)")
    }
    func updateTabBarApperance() {
        if (unreadCount != 0) {
            self.viewControllers![1].tabBarItem.badgeValue = String(unreadCount)
        }
        else {
            self.viewControllers![1].tabBarItem.badgeValue = nil
        }
    }
}

func saveMessageToDatabase(localUserId: String, remoteUserId: String, messageType: Int, isFromSelf: Bool, time: NSDate, messageContent: String) {
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let row: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Chat", inManagedObjectContext: context)
    row.setValue(messageContent, forKey: "content")
    row.setValue(isFromSelf, forKey: "isFromSelf")
    row.setValue(localUserId, forKey: "localUserId")
    row.setValue(messageType, forKey: "messageType")
    row.setValue(remoteUserId, forKey: "remoteUserId")
    row.setValue(time, forKey: "time")

    do {
        try context.save()
    } catch let error as NSError {
        print(error)
    }
    
//    let item = ChatMessage
}

