//
//  NoticeDetailViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire

class NoticeDetailViewController: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var taskData: Task?
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = taskData?.title
        print("have sign up ?")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //报名
    func enrollBtnPressed() {
        print("报名")
        
        Alamofire.request(.POST, serverAddress + "/task/" + self.taskData!.id! + "/join", parameters: nil, encoding: ParameterEncoding.URL, headers: ["Token": token])
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    print("Validation Successful")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showSimpleAlert("", message: "")
                    })
                case .Failure(_, let error):
                    print(error)
                    self.showSimpleAlert("", message: "")
                }
        }
    }

    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 11) {
            let identifier: String = "button"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! NoticeDetailTableCell
            cell.enrollBtn.addTarget(self, action: Selector("enrollBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
            if (taskData!.userHaveSignedUp(userId)) {
                cell.enrollBtn.setTitle("你已经参加", forState: UIControlState.Normal)
                cell.enrollBtn.userInteractionEnabled = false
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        else if (indexPath.row == 7) {
            let identifier: String = "text"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! NoticeDetailTextTableViewCell
            cell.title.text = "模特要求"
            cell.detailText.text = taskData?.modelDemand
            cell.detailText.clipsToBounds = true
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        else if (indexPath.row == 8) {
            let identifier: String = "text"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! NoticeDetailTextTableViewCell
            cell.title.text = "其他要求"
            cell.detailText.text = taskData?.otherDemand
            cell.detailText.clipsToBounds = true
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        else {
            ///有问题
            let identifier: String = "detail"
            guard let cell = tableView.dequeueReusableCellWithIdentifier(identifier) else {
                return UITableViewCell()
            }
            
            switch (indexPath.row) {
            case 0:
                cell.textLabel?.text = "状态"
                cell.detailTextLabel?.text = taskData!.isAllowed ? "报名中" : "已结束"
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
                cell.textLabel?.text = "截止日期"
                cell.detailTextLabel?.text = taskData?.deadLine
            case 5:
                cell.textLabel?.text = "预算报价"
                cell.detailTextLabel?.text = taskData?.price
            case 6:
                cell.textLabel?.text = "工作地址"
                cell.detailTextLabel?.text = taskData?.address
            case 9:
                cell.textLabel?.text = "发布时间"
                cell.detailTextLabel?.text = taskData?.created_at
            case 10:
                cell.textLabel?.text = "联系商家"
                cell.detailTextLabel?.text = ""
            default:
                cell.textLabel?.text = "null"
                cell.detailTextLabel?.text = "default"
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (taskData == nil) {
            return 0
        }
        else {
            return 12
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 7 || indexPath.row == 8) {
            return 180
        }
        return 45.0
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if (indexPath.row == 10) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let chat = sb.instantiateViewControllerWithIdentifier("Chat") as! ChatViewController
            self.navigationController?.pushViewController(chat, animated: true)
        }
    }

}
