//
//  LoginViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/7.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var mobileInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var notice: MBProgressHUD!
    
    @IBAction func loginBtnPressed(sender: AnyObject) {
        print("login pressed")
        if (mobileInput.text == "" || passwordInput.text == "") {
            self.showSimpleAlert("输入有误", message: "请重试")
            return
        }
        guard let mobileText = mobileInput.text else {
            return
        }
        guard let passwordText = passwordInput.text else {
            return
        }
        notice = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        notice.labelText = "登陆中"
        Alamofire.request(.POST, serverAddress + "/user/login", parameters: ["username": mobileText, "password": passwordText,"autoLogin": "1"], encoding: ParameterEncoding.JSON, headers: nil)
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    let user = NSUserDefaults.standardUserDefaults()
                    user.setObject(mobileText, forKey: "UserName")
                    user.setObject(passwordText, forKey: "Password")
                    let resp = LoginResp(JSONDecoder(result.value!))
                    self.checkUserRole(resp)
                case .Failure(_, let error):
                    print(error)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.notice.labelText = "登陆失败"
                        self.notice.hide(true, afterDelay: 1)
                    })
                }
        }

    }
    
    func checkUserRole(resp: LoginResp) {
        Alamofire.request(.GET, serverAddress + "/user/login", parameters:nil, encoding: ParameterEncoding.JSON, headers: ["Token": resp.data!.token!])
        .validate()
        .responseJSON {_, _, result in
                switch result {
                case .Success:
                    isLogin = true
                    userId = resp.data?.userId!
                    token = resp.data?.token
                    unReadCount = ["total": 0]
                    let user = NSUserDefaults.standardUserDefaults()
                    user.setObject(userId, forKey: "UserID")
                    user.setObject(token, forKey: "Token")
                    user.setObject(unReadCount, forKey: "UnreadCount")
                    let fm = NSFileManager.defaultManager()
                    if (fm.fileExistsAtPath(recentChatPlist)) {
                        recentChatList = NSMutableDictionary(contentsOfFile: recentChatPlist)
                    }
                    else {
                        recentChatList = NSMutableDictionary()
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        self.notice.labelText = "登陆成功"
                        self.dismissViewControllerAnimated(false, completion: nil)
                    })
                    
                    let json = JSON(result.value!)
                    if let role = json["data"]["role"].string {
                        print("role: \(role)")
                        switch role {
                        case "guest":
                            userType = .Guest
                        case "model":
                            userType = .Modal
                        case "company":
                            userType = .Company
                        default:
                            userType = .Guest
                        }
                    }
                    else {
                        print("Guest")
                        userType = .Guest
                    }
                    user.setObject(userType.rawValue, forKey: "UserType")
                case .Failure(_, let error):
                    print(error)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.notice.labelText = "登陆失败"
                        self.notice.hide(true, afterDelay: 1)
                    })
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = NSUserDefaults.standardUserDefaults()
        if let _: AnyObject = user.objectForKey("UserName") {
            mobileInput.text = user.objectForKey("UserName") as? String
        }
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
