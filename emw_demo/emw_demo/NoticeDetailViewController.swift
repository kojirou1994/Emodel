//
//  NoticeDetailViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire

class NoticeDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var taskData: Task?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = taskData?.title
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
                        self.showSimpleAlert("报名成功", message: "")
                    })
                case .Failure(_, let error):
                    print(error)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showSimpleAlert("报名失败", message: "")
                    })
                }
        }
    }

    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 13) {
            let identifier: String = "button"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! NoticeDetailTableCell
            cell.enrollBtn.addTarget(self, action: Selector("enrollBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
            if (taskData!.userHaveSignedUp(userId)) {
                cell.enrollBtn.setTitle("你已经参加", forState: UIControlState.Normal)
                cell.enrollBtn.userInteractionEnabled = false
            }
            if (userType == .Company) {
                cell.enrollBtn.setTitle("商家无法报名", forState: UIControlState.Normal)
                cell.enrollBtn.userInteractionEnabled = false
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        else if (indexPath.row == 8) {
            let identifier: String = "text"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! NoticeDetailTextTableViewCell
            cell.title.text = "模特要求"
            cell.detailText.text = taskData?.modelDemand
            cell.detailText.clipsToBounds = true
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        else if (indexPath.row == 9) {
            let identifier: String = "text"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! NoticeDetailTextTableViewCell
            cell.title.text = "其他要求"
            cell.detailText.text = taskData?.otherDemand
            cell.detailText.clipsToBounds = true
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        else if (indexPath.row == 12) {
            let identifier = "SignedPeople"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! SignedPeopleTableViewCell
            cell.people = self.taskData?.participant
            cell.configCell()
            cell.fatherVC = self
            print(self.taskData?.participant)
            return cell
        }
        else {
            ///有问题
            let identifier: String = "detail"
            guard let cell = tableView.dequeueReusableCellWithIdentifier(identifier) else {
                return UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
            }
            cell.accessoryType = UITableViewCellAccessoryType.None
            switch (indexPath.row) {
            case 0:
                cell.textLabel?.text = "状态"
                cell.detailTextLabel?.text = taskData!.isAllowed ? "报名中" : "已结束"
            case 1:
                cell.textLabel?.text = "工作类型"
                cell.detailTextLabel?.text = taskData?.workType
            case 2:
                cell.textLabel?.text = "模特类型"
                cell.detailTextLabel?.text = modelTypeString()
            case 3:
                cell.textLabel?.text = "工作时间"
                cell.detailTextLabel?.text = taskData?.workTime
            case 4:
                cell.textLabel?.text = "需要人数"
                cell.detailTextLabel?.text = String(taskData!.workersCount!)
            case 5:
                cell.textLabel?.text = "截止日期"
                cell.detailTextLabel?.text = taskData?.deadLine
            case 6:
                cell.textLabel?.text = "预算报价"
                cell.detailTextLabel?.text = taskData?.price
            case 7:
                cell.textLabel?.text = "工作地址"
                cell.detailTextLabel?.text = taskData?.address
            case 10:
                cell.textLabel?.text = "发布时间"
                cell.detailTextLabel?.text = taskData?.created_at
            case 11:
                cell.textLabel?.text = "联系商家"
                cell.detailTextLabel?.text = ""
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
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
            return 14
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 8 || indexPath.row == 9) {
            return 180
        }
        if (indexPath.row == 12) {
            return 70
        }
        return 45.0
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if (indexPath.row == 11) {
            let chat = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Chat") as! ChatViewController
            chat.targetUserID = self.taskData?.userId
            self.navigationController?.pushViewController(chat, animated: true)
        }
    }
    
    func modelTypeString() -> String {
        var str = ""
        if (taskData == nil) {
            return str
        }
        for type in self.taskData!.userTypeId! {
            switch (type) {
            case 1:
                str = str + "国内女模 "
            case 2:
                str = str + "国内男模 "
            case 3:
                str = str + "外籍女模 "
            case 4:
                str = str + "外籍男模 "
            case 5:
                str = str + "儿童模特 "
            case 6:
                str = str + "大龄模特 "
            default:
                return str
            }
        }
        return str
    }

}
