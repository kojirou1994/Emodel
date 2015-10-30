//
//  FirstViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire

class PublicNoticeViewController: UIViewController, SMSegmentViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    
    var taskData: [Task]?
    var myTaskData: [Task]?
    var topSegmentView: SMSegmentView!
    var isMy: Bool = false
    var margin: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont.systemFontOfSize(14.0)
        let color = UIColor(hexString: "#ff3f85")
        let set: Dictionary<String, AnyObject> = [keySegmentTitleFont: font, keySegmentOnSelectionColour: color!, keySegmentOffSelectionColour: UIColor.whiteColor(), keyContentVerticalMargin: 10.0]
        self.topSegmentView = SMSegmentView(frame: CGRect(x: self.margin, y: 100.0, width: self.view.frame.size.width - self.margin * 16, height: 30.0), separatorColour: UIColor(white: 0.95, alpha: 0.3), separatorWidth: 0.5, segmentProperties: set)

        self.topSegmentView.delegate = self
        
        self.topSegmentView.layer.cornerRadius = 5.0
        self.topSegmentView.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).CGColor
        self.topSegmentView.layer.borderWidth = 1.0
        
        // Add segments
        self.topSegmentView.addSegmentWithTitle("通告广场", onSelectionImage: UIImage(named: "clip_light"), offSelectionImage: UIImage(named: "clip"))
        self.topSegmentView.addSegmentWithTitle("我的通告", onSelectionImage: UIImage(named: "bulb_light"), offSelectionImage: UIImage(named: "bulb"))
        self.navigationItem.titleView = topSegmentView
        topSegmentView.selectSegmentAtIndex(0)
        setupRefresh()
        updateTaskInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        
    }
    func setupRefresh() {
        self.tableView.addHeaderWithCallback { () -> Void in
            print("下拉刷新啦")
            if (self.isMy) {
                self.updateMyTaskInfo()
            }
            else {
                self.updateTaskInfo()
            }
        }
    }
    func updateTaskInfo() {
        Alamofire.request(.GET, serverAddress + "/task")
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    print("task list get")
                    self.taskData = TaskResp(JSONDecoder(result.value!)).data
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                        self.tableView.headerEndRefreshing()
//                        print(self.taskData!)
                    })
                case .Failure(_, let error):
                    print(error)
                }
        }
    }
    
    func updateMyTaskInfo() {
        
        Alamofire.request(.GET, serverAddress + "/user/" + userId + "/taskinfo", parameters: nil, encoding: ParameterEncoding.URL, headers: ["Token": token])
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    print("mytask list get")
                    self.myTaskData = TaskResp(JSONDecoder(result.value!)).data
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                        self.tableView.headerEndRefreshing()
                    })
                case .Failure(_, let error):
                    print(error)
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

        print("Select segment at index: \(index)")
    }
    
    
    // MARK: - UITableView DataSource Methods

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (isMy) {
            let identifier: String = "noticeTableCell"
            
            var cell: NoticeTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as! NoticeTableCell
            
            if cell == nil {
                cell = NoticeTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
            }
            
            cell.config(myTaskData![indexPath.row])
//            print(cell.timeLabel?.text)
            return cell!
        }
        else {
            let identifier: String = "noticeTableCell"
            
            var cell: NoticeTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as! NoticeTableCell
            
            if cell == nil {
                cell = NoticeTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
            }
            
            cell.config(taskData![indexPath.row])
//            println(cell.timeLabel?.text)
            return cell!
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isMy) {
            if (myTaskData == nil) {
//                print("task count 0")
                return 0
            }
            else {
//                print("task count \(myTaskData!.count)")
                return myTaskData!.count
            }
        }
        else {
            if (taskData == nil) {
                print("task count 0")
                return 0
            }
            else {
                print("task count \(taskData!.count)")
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
        if segue.identifier == "NoticeDetail" {
            let indexPath = self.tableView!.indexPathForSelectedRow
//            print("点击了通告\(indexPath)")
            let destinationViewController = segue.destinationViewController as! NoticeDetailViewController
//            println("taskData transfer")
            if (isMy) {
                destinationViewController.taskData = myTaskData![indexPath!.row]
            }
            else {
                destinationViewController.taskData = taskData![indexPath!.row]
            }
           
        }
    }
}

