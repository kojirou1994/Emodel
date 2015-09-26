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

class LoginViewController: UIViewController {

    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var mobileInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBAction func loginBtnPressed(sender: AnyObject) {
        print("login pressed")
        
        
        if (mobileInput.text == "" || passwordInput.text == "") {
//            mobileInput.text = "请输入信息"
            let ala = UIAlertView(title: "fuck u", message: "shit", delegate: nil, cancelButtonTitle: "ok")
            ala.show()
            return
        }
        guard let mobileText = mobileInput.text else {
            return
        }
        guard let passwordText = passwordInput.text else {
            return
        }
        let notice = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        notice.labelText = "登陆中"
        Alamofire.request(.POST, serverAddress + "/user/login", parameters: ["username": mobileText, "password": passwordText,"autoLogin": "1"], encoding: ParameterEncoding.JSON, headers: nil)
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    let resp = LoginResp(JSONDecoder(result.value!))
                    isLogin = true
                    print("status is: \(resp.status!)")
                    print("userId is:\(resp.data!.userId!)")
                    print("token is:\(resp.data!.token)")
                    userId = resp.data?.userId!
                    token = resp.data?.token
                    unReadCount = ["total": 0]
                    let user = NSUserDefaults.standardUserDefaults()
                    user.setObject(mobileText, forKey: "UserName")
                    user.setObject(passwordText, forKey: "Password")
                    user.setObject(userId, forKey: "UserID")
                    user.setObject(token, forKey: "Token")
                    user.setObject(unReadCount, forKey: "UnreadCount")
                    recentChatList = NSMutableDictionary(contentsOfFile: recentChatPlist!)
                    userNameAndAvatarStorage = Dictionary<String, Dictionary<String, String>>()
                    user.setObject(userNameAndAvatarStorage, forKey: "UserNameAndAvatarStorage")
                    dispatch_async(dispatch_get_main_queue(), {
                        notice.labelText = "登陆成功"
                        self.dismissViewControllerAnimated(false, completion: nil)
                    })
                case .Failure(_, let error):
                    dispatch_async(dispatch_get_main_queue(), {
                        notice.labelText = "登陆失败"
                        notice.hide(true, afterDelay: 1)
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
