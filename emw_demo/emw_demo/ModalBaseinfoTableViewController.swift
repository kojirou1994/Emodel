//
//  ModalBaseinfoTableViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/28.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire

class ModalBaseinfoTableViewController: UITableViewController {

    var targetUserId: String!
    var targetUserData: UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ModalBaseInfo")
        Alamofire.request(.GET, serverAddress + "/user/\(targetUserId)")
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    self.targetUserData = User(JSONDecoder(result.value!)).data
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                case .Failure(_, let error):
                    print(error)
                    return
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    let data = ["QQ", "生日","邮箱","手机号","用户名","真实姓名","性别","微信账号"]
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return targetUserData == nil ? 0 : data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ModalBaseInfo", forIndexPath: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        print(targetUserData?.baseInfo?.QQ)
        cell.selectionStyle = .None
        switch indexPath.row {
        case 0:
            cell.detailTextLabel?.text = targetUserData?.baseInfo?.QQ
        case 1:
            cell.detailTextLabel?.text = targetUserData?.baseInfo?.birthday
        case 2:
            cell.detailTextLabel?.text = targetUserData?.baseInfo?.email
        case 3:
            cell.detailTextLabel?.text = targetUserData?.baseInfo?.mobile
        case 4:
            cell.detailTextLabel?.text = targetUserData?.baseInfo?.nickName
        case 5:
            cell.detailTextLabel?.text = targetUserData?.baseInfo?.realName
        case 6:
            cell.detailTextLabel?.text = targetUserData?.baseInfo?.sex
        case 7:
            cell.detailTextLabel?.text = targetUserData?.baseInfo?.wechat
        default:
            print("oh")
        }
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
