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
//        self.navigationItem.leftBarButtonItem = btn
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
    
    func stringByDate(date: NSDate) -> String {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let todayDate = format.dateFromString(format.stringFromDate(NSDate()))!
        let interval = date.timeIntervalSinceDate(todayDate)
        if ( interval >= 0) {
            format.dateFormat = "HH:mm:ss"
            return format.stringFromDate(date)
        }
        else if (interval < -86400) {
            format.dateFormat = "MM-dd"
            return format.stringFromDate(date)
        }
        else {
            return "昨天"
            
        }
    }
    
//    MARK : - YunbaService
    func addNotificationHandler() {
        let defaultNC = NSNotificationCenter.defaultCenter()
        defaultNC.addObserver(self, selector: "updateChatList", name: "updateChatListVC", object: nil)
        defaultNC.addObserver(self, selector: "onConnectionStateChanged:", name: kYBConnectionStatusChangedNotification, object: nil)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("setting the rows number")
        print(recentChatList.count)
        return recentChatList.count
    }
//    var name = ["king","Cici"]
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("setting the cell")
        let cell = chatListTableView.dequeueReusableCellWithIdentifier("chatListCell") as! ChatListTableViewCell
        cell.userNameLabel.text = listIndex[indexPath.row]["userId"] as? String
        cell.latestMessageLabel.text = recentChatList[listIndex[indexPath.row]["userId"] as! String]!["message"] as! String
        cell.timeLabel.text = stringByDate(recentChatList[listIndex[indexPath.row]["userId"] as! String]!["time"] as! NSDate)
        cell.configTheCell(unReadCount[listIndex[indexPath.row]["userId"] as! String]!, id: listIndex[indexPath.row]["userId"] as! String)
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        unReadCount["total"] = unReadCount["total"]! - unReadCount[listIndex[indexPath.row]["userId"] as! String]!
        unReadCount[listIndex[indexPath.row]["userId"] as! String] = 0
        let tb = self.tabBarController as! MainTabBar
        tb.updateTabBarApperance()
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChatListTableViewCell
        cell.configTheCell(0, id: listIndex[indexPath.row]["userId"] as! String)
        NSUserDefaults.standardUserDefaults().setObject(unReadCount, forKey: "UnreadCount")
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

