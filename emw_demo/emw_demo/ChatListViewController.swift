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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    var name = ["阿花","XD","猫叔","阿猫","阿狗","阿三","null","想不出了"]
        // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
        // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = chatListTableView.dequeueReusableCellWithIdentifier("chatListCell") as! ChatListTableViewCell
        cell.userNameLabel.text = name[indexPath.row]
        cell.latestMessageLabel.text = "你欠我的钱什么时候还"
        cell.timeLabel.text = "昨天"
//        cell.userAvatar.contentMode = UIViewContentMode.
        cell.userAvatar.image = UIImage(named: "head.jpg")
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

