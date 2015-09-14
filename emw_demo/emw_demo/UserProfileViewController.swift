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
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet var mainTableView: UITableView!
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
        //更新界面元素
        setRefresh()
        updateInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setRefresh() {
        self.mainTableView.addHeaderWithCallback { () -> Void in
            self.updateUserInfo()
        }
    }
    func updateUserInfo() {
        var getUserInfo: Bool = false
        var getBaseInfo: Bool = false
        
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
                    if (getBaseInfo) {
                        var temp = localUser.baseInfo
                        localUser = resp.data
                        localUser.baseInfo = temp
                        println(localUser.baseInfo?.QQ)
                    }
                    else {
                        localUser = resp.data
                    }
                    println(localUser!.star)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.updateInterface()
                        self.mainTableView.headerEndRefreshing()
                    })
                default:
                    println("get user info failed")
                }
            }
        }
        
        // baseinfo额外获取一次
        var base = HTTPTask()
        base.requestSerializer = HTTPRequestSerializer()
        base.requestSerializer.headers["Token"] = token
        base.GET(serverAddress + "/user/\(userId!)/baseinfo", parameters: nil) { (response: HTTPResponse) -> Void in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                println("获取到的baseinfo")
                println(response.description)
                let resp = BaseInfoResp(JSONDecoder(obj))
                if (resp.status == 200) {
                    println("success")
                    getBaseInfo = true
                    localUser.baseInfo = resp.data
                    println("update baseinfo ok")
                    println(resp.data!.QQ)
                    println("birthday \(localUser.baseInfo?.birthday)")
                }
            }
        }

    }
    
    func updateInterface() {
//        var userAvatar = UIImageView(frame: CGRectMake(0, 0, Avatar.bounds.width, Avatar.bounds.height))
//        userAvatar.contentMode = UIViewContentMode.ScaleAspectFill
//        userAvatar.kf_setImageWithURL()
//        println(localUser.baseInfo!.avatar!)
//        Avatar.addSubview(userAvatar)
        Avatar.kf_setImageWithURL(NSURL(string: localUser.baseInfo!.avatar!)!, forState: UIControlState.Normal)
        UserNameLabel.text = localUser.baseInfo?.nickName
        likeCountLabel.text = String(localUser.like!.count!)
        StarRankImage.image = UIImage(named: "starRank_\(localUser.star).png")
        self.mainTableView.headerEndRefreshing()
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
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.uploadAvatar()
        })
//        uploadAvatar()
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
                    self.updateUserInfo()
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
    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "GoToCalendar" {
            var calen = HTTPTask()
            calen.GET(serverAddress + "/user/\(userId!)/calendar", parameters: nil) { (response: HTTPResponse) -> Void in
                if let err = response.error {
                    println("error: \(err.localizedDescription)")
                    return
                }
                if let obj: AnyObject = response.responseObject {
                    println("获取到的baseinfo")
                    println(obj)
                    let resp = BaseInfoResp(JSONDecoder(obj))
                    if (resp.status == 200) {
                    }
                }
            }
            return true
        }
        return true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

}
