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

    var statusString: String?
    var workString: String?
    var timeString: String?
    var locationString: String?
    var modelString: String?
    var peopleString: String?
    var salaryString: String?
    var otherString: String?
    
    @IBOutlet weak var tableView: UITableView!
    var details:[NoticeDetailForm] = []

    @IBAction func submitBtnPressed(sender: AnyObject) {
        var alert = UIAlertController(title: "报名成功", message: "报名成功", preferredStyle: UIAlertControllerStyle.Alert)
        var actionYes = UIAlertAction(title: "返回", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(actionYes)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var submitBtnPressed: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "人鱼大片儿创作"
        initializeTheNotices()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeTheNotices() {
        self.details = [NoticeDetailForm(title: "状态", prop: "报名中"),
            NoticeDetailForm(title: "工作", prop: "服装拍摄"),
            NoticeDetailForm(title: "时间", prop: "7月10日上午"),
            NoticeDetailForm(title: "地点", prop: "杭州市"),
            NoticeDetailForm(title: "模特", prop: "外籍女模 外籍男模"),
            NoticeDetailForm(title: "人数", prop: "各2人"),
            NoticeDetailForm(title: "报酬", prop: "800元/小时左右"),
            NoticeDetailForm(title: "其他要求", prop: "略"),
            NoticeDetailForm(title: "已报名", prop: "4人")
        ]
        self.tableView?.reloadData()
        
    }

    // MARK: - UITableView DataSource Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "noticeDetailTableCell"
        
        var cell: NoticeDetailTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? NoticeDetailTableCell
        
        if cell == nil {
            cell = NoticeDetailTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        cell.configurateTheCell(details[indexPath.row])
//        println(cell.timeLabel?.text)
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        println("count\(notices.count)")
        return details.count
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
