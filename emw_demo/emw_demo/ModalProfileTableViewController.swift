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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        chatButton.layer.masksToBounds = true
        chatButton.layer.cornerRadius = 5
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
