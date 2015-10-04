//
//  UserProfileViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD
import Alamofire

class UserProfileViewController: UITableViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var Avatar: UIButton!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var StarRankImage: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet var mainTableView: UITableView!
    @IBAction func AvatarBtnPressed(sender: AnyObject) {
        print("改变头像")
        
        let sheet: UIActionSheet = UIActionSheet()
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
        
        self.mainTableView.tableFooterView = UIView()
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
        var getUserInfo: Bool?
        var getBaseInfo: Bool?
        
        //获取user信息
        Alamofire.request(.GET, serverAddress + "/user/\(userId!)")
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    let resp = User(JSONDecoder(result.value!))
                    getUserInfo = true
                    guard let getAnother = getBaseInfo else {
                        localUser = resp.data
                        return
                    }
                    if (getAnother) {
                        let temp = localUser.baseInfo
                        localUser = resp.data
                        localUser.baseInfo = temp
                        print("从user进入")
                        dispatch_async(dispatch_get_main_queue(), {
                            self.updateInterface()
                            self.mainTableView.headerEndRefreshing()
                        })
                    }
                    else {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.mainTableView.headerEndRefreshing()
                            self.showSimpleAlert("fail", message: "")
                        })
                    }
                case .Failure(_, let error):
                    print(error)
                    return
                }
        }
        
        // baseinfo额外获取一次
        Alamofire.request(.GET, serverAddress + "/user/\(userId!)/baseinfo", parameters: nil, encoding: ParameterEncoding.URL, headers: ["Token": token])
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    let resp = BaseInfoResp(JSONDecoder(result.value!))
                    getBaseInfo = true
                    guard let getAnother = getUserInfo else {
                        localUser.baseInfo = resp.data
                        return
                    }
                    if (getAnother) {
                        localUser.baseInfo = resp.data
                        print("从base进入")
                        dispatch_async(dispatch_get_main_queue(), {
                            self.mainTableView.headerEndRefreshing()
                        })
                    }
                    else {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.showSimpleAlert("fai;", message: "")
                            self.mainTableView.headerEndRefreshing()
                        })
                    }
                case .Failure(_, let error):
                    print(error)
                    return
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
            print("button Index: \(buttonIndex)")
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - UIImagePickerControllerDelegate
    var imageData: NSData?

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageData = UIImageJPEGRepresentation(pickedImage, 0.5)!
//            imageData!.writeToFile(newAvatarPath, atomically: false)
            dismissViewControllerAnimated(true, completion: { () -> Void in
                self.uploadAvatar(self.imageData!)
            })
        }

//        uploadAvatar()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - Func
    func uploadAvatar(avatarData: NSData) {
        let notice = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        notice.labelText = "上传中"
        print("地址")
        print(serverAddress + "/user/" + userId + "/avatar")
        print("token:\n" + token)
        let boundary = Web.multipartBoundary()
        let request = Web.multipartRequest("PUT", NSURL(string: serverAddress + "/user/" + userId + "/avatar")!, boundary)
        request.setValue(token, forHTTPHeaderField: "Token")
        let fields = ["userId": userId as String]
        let data = Web.multipartData(boundary, fields, avatarData)
        
        let dataTask = NSURLSession.sharedSession().uploadTaskWithRequest(request, fromData: data) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil) {
                print(error)
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
            print(response)
        }
        dataTask.resume()
        print("uploading avatar")
    }
    
    func ajustAvatar(source: UIImage) -> UIImage {
        print(source.size.height)
        print(source.size.width)
        return source
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
//        if identifier == "GoToCalendar" {
//            var calen = HTTPTask()
//            calen.GET(serverAddress + "/user/\(userId!)/calendar", parameters: nil) { (response: HTTPResponse) -> Void in
//                if let err = response.error {
//                    print("error: \(err.localizedDescription)")
//                    return
//                }
//                if let obj: AnyObject = response.responseObject {
//                    print("获取到的baseinfo")
//                    print(obj)
//                    let resp = BaseInfoResp(JSONDecoder(obj))
//                    if (resp.status == 200) {
//                    }
//                }
//            }
//            return true
//        }
        return true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

}
