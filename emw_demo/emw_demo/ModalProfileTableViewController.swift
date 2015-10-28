//
//  ModalProfileTableViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/26.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit

class ModalProfileTableViewController: UITableViewController {

    var targetUserId: String!
    
    @IBOutlet weak var chatButton: UIButton!
    
    @IBAction func chatButtonTapped(sender: AnyObject) {
        let chat = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Chat") as! ChatViewController
        chat.targetUserID = self.targetUserId
        self.navigationController?.pushViewController(chat, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        chatButton.layer.masksToBounds = true
        chatButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default :
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("ModalCell", forIndexPath: indexPath) as! ModalProfileTableViewCell
            cell.configTheCell(targetUserId)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("ModalAlbumCell", forIndexPath: indexPath)
            return cell
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("ModalProfileCell", forIndexPath: indexPath)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("ModalProfileCell", forIndexPath: indexPath)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("ModalProfileCell", forIndexPath: indexPath)
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("ModalProfileCell", forIndexPath: indexPath)
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("ModalProfileCell", forIndexPath: indexPath)
            
            // Configure the cell...
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 2) {
            return 40
        }
        return 0
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 1:
            return 70
        case 2:
            return 44
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "ToModalBaseinfo") {
            let v = segue.destinationViewController as! ModalBaseinfoTableViewController
            v.targetUserId = self.targetUserId
        }
        else if (segue.identifier == "ToModalAlbum") {
            let v = segue.destinationViewController as! AlbumViewController
            v.targetUserId = self.targetUserId
        }
        
    }
    

}
