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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNotificationHandler()
//        let sendbtn = UIBarButtonItem(title: "send", style: UIBarButtonItemStyle.Plain, target: self, action: "sendMessage")
//        self.navigationItem.leftBarButtonItem = sendbtn
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //MARK : - YunbaService
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
        if (YunBaService.isConnected()) {
            print("didConnect")
        }
        else {
            print("didDisconected")
        }
    }
    func onMessageReceived(notification: NSNotification) {
        let message: YBMessage = notification.object as! YBMessage
        print("new message \(message.data.length) bytes, topic = \(message.topic)")
        let payloadString = NSString(data: message.data, encoding: NSUTF8StringEncoding)
        print("data: \(payloadString)")
    }
    
    func onPresenceReceived(notification: NSNotification) {
        let presence: YBPresenceEvent = notification.object as! YBPresenceEvent
        print("new presence, action = \(presence.action), topic = \(presence.topic), alias = \(presence.alias), time = \(presence.time)")
        
//        NSString *curMsg = [NSString stringWithFormat:@"[Presence] %@:%@ => %@[%@]", [presence topic], [presence alias], [presence action], [NSDateFormatter localizedStringFromDate:[NSDate dateWithTimeIntervalSince1970:[presence time]/1000] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]];
//        [self addMsgToTextView:curMsg];
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    var name = ["king","Cici"]
        // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
        // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = chatListTableView.dequeueReusableCellWithIdentifier("chatListCell") as! ChatListTableViewCell
        cell.userNameLabel.text = name[indexPath.row]
        cell.latestMessageLabel.text = "发谁点谁"
        cell.timeLabel.text = "昨天"
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
            cvc.targetUserID = index?.row == 0 ? "55a7abda8a5da518db646c18" : "55a7abda8a5da518db646c23"
        }
    }
}

