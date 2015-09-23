//
//  ViewController.swift
//  Yunba
//
//  Created by 王宇 on 15/9/9.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatListTableView: UITableView!
    
    var listIndex: [Dictionary<String, AnyObject>]!
    
    override func viewDidLoad() {
        print("chat list loaded")
        super.viewDidLoad()
        chatListVCLoaded = true
//        self.addNotificationHandler()
        self.chatListTableView.tableFooterView = UIView(frame: CGRectZero)
        let btn = UIBarButtonItem(title: "refresh", style: UIBarButtonItemStyle.Plain, target: self, action: "updateChatList")
        self.navigationItem.leftBarButtonItem = btn
        if (recentChatList.count > 0){
            self.updateChatList()
        }
        self.addNotificationHandler()
    }
    func updateChatList() {
        print("count: \(recentChatList.count)")
        if (recentChatList.count > 0){
            listIndex = [Dictionary<String, AnyObject>]()
            let keys = recentChatList.allKeys as! [String]
            print("keys")
            print(keys)
            for (var i = 0; i < recentChatList.count; i++) {
                listIndex.append(["userId": keys[i],"time": recentChatList[keys[i]]!.valueForKey("time")!])
//                    addObject(["userId": "","time": recentChatList[keys[i]]!.valueForKey("time")!])
            }
            listIndex = listIndex.sort { (T, U) -> Bool in
                print("sorted")
                return (T["time"] as! NSDate).timeIntervalSinceDate(U["time"] as! NSDate) > 0.0
            }
        }
        print(recentChatList)
        print("listIndex")
//        print(listIndex)
        self.chatListTableView.reloadData()
    }
//    MARK : - YunbaService
    func addNotificationHandler() {
        let defaultNC = NSNotificationCenter.defaultCenter()
        defaultNC.addObserver(self, selector: "onConnectionStateChanged:", name: kYBConnectionStatusChangedNotification, object: nil)
        defaultNC.addObserver(self, selector: "onMessageReceived:", name: kYBDidReceiveMessageNotification, object: nil)
        defaultNC.addObserver(self, selector: "onPresenceReceived", name: kYBDidReceivePresenceNotification, object: nil)
    }
    func removeNotificationHandler() {
        let defaultNC = NSNotificationCenter.defaultCenter()
        defaultNC.removeObserver(self)
    }
    
    func onConnectionStateChanged(notification: NSNotification) {
//        if (YunBaService.isConnected()) {
//            print("didConnect")
//        }
//        else {
//            print("didDisconected")
//        }
    }
    func onMessageReceived(notification: NSNotification) {
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "updateChatList", userInfo: nil, repeats: false)
    }
    
    func onPresenceReceived(notification: NSNotification) {
//        let presence: YBPresenceEvent = notification.object as! YBPresenceEvent
//        print("new presence, action = \(presence.action), topic = \(presence.topic), alias = \(presence.alias), time = \(presence.time)")
//    
//        NSString *curMsg = [NSString stringWithFormat:@"[Presence] %@:%@ => %@[%@]", [presence topic], [presence alias], [presence action], [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:[presence time]/1000] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]];
//        [self addMsgToTextView:curMsg];
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("setting the rows number")
        return recentChatList.count
    }
//    var name = ["king","Cici"]
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("setting the cell")
        let cell = chatListTableView.dequeueReusableCellWithIdentifier("chatListCell") as! ChatListTableViewCell
        cell.userNameLabel.text = listIndex[indexPath.row]["userId"] as? String
        cell.latestMessageLabel.text = recentChatList[listIndex[indexPath.row]["userId"] as! String]!["message"] as! String
        cell.timeLabel.text = "time"
//        cell.userAvatar.contentMode = UIViewContentMode.
        cell.userAvatar.image = UIImage(named: "head.jpg")
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "GoToChat") {
            let cvc = segue.destinationViewController as! ChatViewController
            let index = self.chatListTableView.indexPathForSelectedRow
            cvc.targetUserID = listIndex[(index?.row)!]["userId"] as! String
        }
    }
    
    override func viewDidAppear(animated: Bool) {
    }
}

