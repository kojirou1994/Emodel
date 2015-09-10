//
//  NoticeDetailViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class NoticeDetailForm: NSObject {
    let title: String
    let prop: String

    init(title: String, prop: String) {
        self.title = title
        self.prop = prop
    }
}


class NoticeDetailViewController: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var taskData: Task?
    
    @IBOutlet weak var tableView: UITableView!

    @IBAction func submitBtnPressed(sender: AnyObject) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = taskData?.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func enrollBtnPressed() {
        println("报名")
        var alert = UIAlertController(title: "报名成功", message: "报名成功", preferredStyle: UIAlertControllerStyle.Alert)
        var actionYes = UIAlertAction(title: "返回", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(actionYes)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: - UITableView DataSource Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 10) {
            let identifier: String = "button"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! NoticeDetailTableCell
            cell.enrollBtn.addTarget(self, action: Selector("enrollBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        }
        else {
            let identifier: String = "detail"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! UITableViewCell
            switch (indexPath.row) {
            case 0:
                cell.textLabel?.text = "状态"
                cell.detailTextLabel?.text = taskData?.price
            case 1:
                cell.textLabel?.text = "工作类型"
                cell.detailTextLabel?.text = taskData?.workType
            case 2:
                cell.textLabel?.text = "工作时间"
                cell.detailTextLabel?.text = taskData?.workTime
            case 3:
                cell.textLabel?.text = "需要人数"
                cell.detailTextLabel?.text = String(taskData!.workersCount!)
            case 4:
                cell.textLabel?.text = taskData?.title
                cell.detailTextLabel?.text = taskData?.price
            case 5:
                cell.textLabel?.text = "预算报价"
                cell.detailTextLabel?.text = taskData?.price
            case 6:
                cell.textLabel?.text = "工作地址"
                cell.detailTextLabel?.text = taskData?.address
            case 7:
                cell.textLabel?.text = "模特要求"
                cell.detailTextLabel?.text = taskData?.modelDemand
            case 8:
                cell.textLabel?.text = "其他要求"
                cell.detailTextLabel?.text = taskData?.otherDemand
            case 9:
                cell.textLabel?.text = "发布时间"
                cell.detailTextLabel?.text = taskData?.created_at
            default:
                cell.textLabel?.text = "null"
                cell.detailTextLabel?.text = "default"
            }
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        println("count\(notices.count)")
        if (taskData == nil) {
            return 0
        }
        else {
            return 11
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
    //MARK: - UITableView Delegate Method
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
