//
//  UserProfileViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import JSONJoy
import SwiftHTTP
import Kingfisher
import MBProgressHUD

class UserProfileViewController: UITableViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var Avatar: UIButton!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var StarRankImage: UIImageView!
    @IBAction func AvatarBtnPressed(sender: AnyObject) {
        println("改变头像")
        
        var sheet: UIActionSheet = UIActionSheet()
        let title: String = "选择照片"
        sheet.title  = title
        sheet.delegate = self
        sheet.addButtonWithTitle("取消")
        sheet.addButtonWithTitle("从相册选择")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            sheet.addButtonWithTitle("拍照")
        }
        sheet.cancelButtonIndex = 0
        sheet.showInView(self.view)
        sheet.tag = 255
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //圆形头像
        Avatar.layer.masksToBounds = true
        Avatar.layer.cornerRadius = Avatar.frame.height / 2
        Avatar.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.clearsSelectionOnViewWillAppear = true
        //加载用户头像
        var userAvatar = UIImageView(frame: CGRectMake(0, 0, Avatar.bounds.width, Avatar.bounds.height))
        userAvatar.contentMode = UIViewContentMode.ScaleAspectFill
        userAvatar.kf_setImageWithURL(NSURL(string: localUser.baseInfo!.avatar!)!)
        Avatar.addSubview(userAvatar)
        //更新用户名、评级
        UserNameLabel.text = localUser.baseInfo?.nickName
        StarRankImage.image = UIImage(named: "starRank_\(localUser.star).png")
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUserInfo() {
        var request = HTTPTask()
        request.GET(serverAddress + "/user/\(userId!)", parameters: nil) { (response: HTTPResponse) -> Void in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                let resp = User(JSONDecoder(obj))
                switch (resp.status!) {
                case 200:
                    println("update UserInfo success")
                    localUser = resp.data
                    println(localUser!.star)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.performSegueWithIdentifier("showMainTab", sender: self)
                    })
                default:
                    println("get user info failed")
                }
            }
        }

    }
    
    func updateInterface() {
        var userAvatar = UIImageView(frame: CGRectMake(0, 0, Avatar.bounds.width, Avatar.bounds.height))
        userAvatar.contentMode = UIViewContentMode.ScaleAspectFill
        userAvatar.kf_setImageWithURL(NSURL(string: localUser.baseInfo!.avatar!)!)
        println(localUser.baseInfo!.avatar!)
        Avatar.addSubview(userAvatar)
        UserNameLabel.text = localUser.baseInfo?.nickName
        StarRankImage.image = UIImage(named: "starRank_\(localUser.star).png")
    }
    
    //MARK: - UIActionSheetDelegate
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet.tag == 255 {
            let imagePicker:UIImagePickerController = UIImagePickerController();
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                switch (buttonIndex) {
                case 0:
                    return
                case 1:
                    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                case 2:
                    imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                    imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Front
                default:
                    break;
                }
            }
            else {
                if (buttonIndex == 0) {
                    return
                }
                else {
                    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                }
            }
            println("button Index: \(buttonIndex)")
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - UIImagePickerControllerDelegate
    var imageData: NSData?
    let newAvatarPath:String = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent("newAvatar.jpg")
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageData = UIImageJPEGRepresentation(pickedImage, 0.5)
            imageData!.writeToFile(newAvatarPath, atomically: false)
            println(newAvatarPath)
            println("already 保存")
        }
        dismissViewControllerAnimated(true, completion: nil)
        uploadAvatar()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - Func
    func uploadAvatar() {
        let notice = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        notice.labelText = "上传中"
        println("地址")
        println(serverAddress + "/user/" + userId + "/avatar")
        println("token:\n" + token!)
        let boundary = Web.multipartBoundary()
        let request = Web.multipartRequest("PUT", NSURL(string: serverAddress + "/user/" + userId + "/avatar")!, boundary)
        request.setValue(token, forHTTPHeaderField: "Token")
        let fields = ["userId": userId as String]
        let data = Web.multipartData(boundary, fields, NSData(contentsOfFile: newAvatarPath)!)
        let dataTask = NSURLSession.sharedSession().uploadTaskWithRequest(request, fromData: data) { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if (error != nil) {
                println(error)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    notice.labelText = "上传失败，请重试！"
                    notice.hide(true, afterDelay: 1)
                })
            }
            else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    notice.labelText = "上传成功"
                    notice.hide(true, afterDelay: 0.5)
                })
            }
            println(response)
        }
        dataTask.resume()
        println("uploading avatar")
    }
    
    func ajustAvatar(source: UIImage) -> UIImage {
        println(source.size.height)
        println(source.size.width)
        return source
    }
    // 没用
    func saveImage(currentImage: UIImage, imageName: NSString) {
        var imageData:NSData = UIImageJPEGRepresentation(currentImage, 0.5)
        var fullPath:NSString = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(imageName as String)
        imageData.writeToFile(fullPath as String, atomically: false)
        println("already 保存")
        
    }

    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
