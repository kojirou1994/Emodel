//
//  ConfigViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/2.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class ConfigViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "   "
    }
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "   "
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 2) {
            return 22
        }
        else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    // MARK: - TableviewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 2 && indexPath.row == 0) {
            isLogin = false
            let user = NSUserDefaults.standardUserDefaults()
            user.removeObjectForKey("UserName")
            println("已移除用户信息")
            let ent = UIStoryboard(name: "Main", bundle: nil)
            let a = ent.instantiateInitialViewController() as! UIViewController
            self.presentViewController(a, animated: true, completion: nil)
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                let cell = tableView.dequeueReusableCellWithIdentifier("Detail", forIndexPath: indexPath) as! UITableViewCell
                cell.textLabel?.text = "cache"
                cell.detailTextLabel?.text = "3.6MB"
                return cell
            }
        }
        else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                let cell = tableView.dequeueReusableCellWithIdentifier("Link", forIndexPath: indexPath) as! UITableViewCell
                cell.textLabel?.text = "APP STORE LINK"
                return cell
            }
            else if (indexPath.row == 1) {
                let cell = tableView.dequeueReusableCellWithIdentifier("Link", forIndexPath: indexPath) as! UITableViewCell
                cell.textLabel?.text = "ABOUT"
                return cell
            }
        }
        else if (indexPath.section == 2){
            if (indexPath.row == 0) {
                let cell = tableView.dequeueReusableCellWithIdentifier("Link", forIndexPath: indexPath) as! UITableViewCell
                cell.textLabel?.text = "退出登录"
                return cell
            }
        }
        else {
            
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("Link", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = ""
        return cell
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "LogOut") {
            isLogin = false
            
        }
    }


}
