//
//  FirstViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

class PublicNoticeViewController: UIViewController, UINavigationControllerDelegate, SMSegmentViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    
    @IBAction func updateBtnPressed(sender: AnyObject) {
        if (isMy) {
            updateMyTaskInfo()
        }
        else {
            updateTaskInfo()
        }
    }
    
    var taskData: [Task]?
    var myTaskData: [Task]?
    var topSegmentView: SMSegmentView!
    var isMy: Bool = false
    var margin: CGFloat = 10.0
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.topSegmentView = SMSegmentView(frame: CGRect(x: self.margin, y: 100.0, width: self.view.frame.size.width - self.margin*16, height: 30.0), separatorColour: UIColor(white: 0.95, alpha: 0.3), separatorWidth: 0.5, segmentProperties: [keySegmentTitleFont: UIFont.systemFontOfSize(12.0), keySegmentOnSelectionColour: UIColor(red: 245.0/255.0, green: 174.0/255.0, blue: 63.0/255.0, alpha: 1.0), keySegmentOffSelectionColour: UIColor.whiteColor(), keyContentVerticalMargin: Float(10.0)])
        
        self.topSegmentView.delegate = self
        
        self.topSegmentView.layer.cornerRadius = 5.0
        self.topSegmentView.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).CGColor
        self.topSegmentView.layer.borderWidth = 1.0
        
        // Add segments
        self.topSegmentView.addSegmentWithTitle("通告广场", onSelectionImage: UIImage(named: "clip_light"), offSelectionImage: UIImage(named: "clip"))
        self.topSegmentView.addSegmentWithTitle("我的通告", onSelectionImage: UIImage(named: "bulb_light"), offSelectionImage: UIImage(named: "bulb"))
        self.navigationItem.titleView = topSegmentView
        topSegmentView.selectSegmentAtIndex(0)

        updateTaskInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        
    }
    
    func updateTaskInfo() {
        var getTask = HTTPTask()
        getTask.GET(serverAddress + "/task", parameters: nil) { (response: HTTPResponse) -> Void in
            println(response.description)
            if let err = response.error {
                println("get task list error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                println("task list get")
                self.taskData = TaskResp(JSONDecoder(obj)).data
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView?.reloadData()
                })
            }
        }
    }
    
    func updateMyTaskInfo() {
        var getMyTask = HTTPTask()
        getMyTask.requestSerializer = HTTPRequestSerializer()
        getMyTask.requestSerializer.headers["Token"] = token
        getMyTask.GET(serverAddress + "/user/" + userId + "/taskinfo", parameters: nil) { (response: HTTPResponse) -> Void in
            println(response.description)
            if let err = response.error {
                println("get task list error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                println("task list get")
                self.myTaskData = TaskResp(JSONDecoder(obj)).data
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView?.reloadData()
                })
            }
        }
    }
    // SMSegment Delegate
    func segmentView(segmentView: SMSegmentView, didSelectSegmentAtIndex index: Int) {
        if index == 0 {
//            initializeTheNotices()
            //通告广场
            isMy = false
            updateTaskInfo()
            self.tableView.reloadData()
        }
        else {
            //我的通告
            isMy = true
            updateMyTaskInfo()
            self.tableView.reloadData()
        }

        println("Select segment at index: \(index)")
    }
    
    
    // MARK: - UITableView DataSource Methods

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (isMy) {
            let identifier: String = "noticeTableCell"
            
            var cell: NoticeTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? NoticeTableCell
            
            if cell == nil {
                cell = NoticeTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
            }
            
            cell.config(myTaskData![indexPath.row])
            println(cell.timeLabel?.text)
            return cell!
        }
        else {
            let identifier: String = "noticeTableCell"
            
            var cell: NoticeTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? NoticeTableCell
            
            if cell == nil {
                cell = NoticeTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
            }
            
            cell.config(taskData![indexPath.row])
            println(cell.timeLabel?.text)
            return cell!
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isMy) {
            if (myTaskData == nil) {
                println("task count 0")
                return 0
            }
            else {
                println("task count \(myTaskData!.count)")
                return myTaskData!.count
            }
        }
        else {
            if (taskData == nil) {
                println("task count 0")
                return 0
            }
            else {
                println("task count \(taskData!.count)")
                return taskData!.count
            }
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    
    //MARK: - UITableView Delegate Method
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "noticeDetail" {
            let indexPath = self.tableView!.indexPathForSelectedRow()
            println("点击了通告\(indexPath)")
            let destinationViewController = segue.destinationViewController as! NoticeDetailViewController
            println("taskData transfer")
            destinationViewController.taskData = taskData![indexPath!.row]
        }
    }
}

