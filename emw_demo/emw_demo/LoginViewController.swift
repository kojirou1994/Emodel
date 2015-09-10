//
//  LoginViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/7.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import JSONJoy
import SwiftHTTP
import MBProgressHUD

class LoginViewController: UIViewController {

    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var mobileInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBAction func loginBtnPressed(sender: AnyObject) {
        println("login pressed")
        
        
        if (mobileInput.text == "" || passwordInput.text == "") {
//            mobileInput.text = "请输入信息"
            let ala = UIAlertView(title: "fuck u", message: "shit", delegate: nil, cancelButtonTitle: "ok")
            ala.show()
            return
        }
        let notice = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        notice.labelText = "登陆中"
        var request = HTTPTask()
        let params: Dictionary<String,AnyObject> = ["username": mobileInput.text, "password": passwordInput.text,"autoLogin": "1"]
        request.POST(serverAddress + "/user/login", parameters: params, completionHandler: {(response: HTTPResponse) in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
                dispatch_async(dispatch_get_main_queue(), {
                    notice.labelText = "登陆失败"
                    notice.hide(true, afterDelay: 1)
                })
                return
            }
            if let obj: AnyObject = response.responseObject {
                let resp = LoginResp(JSONDecoder(obj))
                switch resp.status! {
                case 200:
                    isLogin = true
                    println("status is: \(resp.status!)")
                    println("userId is:\(resp.data!.userId!)")
                    println("token is:\(resp.data!.token!)")
                    userId = resp.data?.userId!
                    token = resp.data?.token!
                    let user = NSUserDefaults.standardUserDefaults()
                    user.setObject(self.mobileInput.text, forKey: "UserName")
                    user.setObject(self.passwordInput.text, forKey: "Password")
                    user.setObject(userId, forKey: "UserID")
                    user.setObject(token, forKey: "Token")
                    dispatch_async(dispatch_get_main_queue(), {
                        notice.labelText = "登陆成功"
                        self.dismissViewControllerAnimated(false, completion: nil)
                    })
//
                case 400:
                    println("error")
                    dispatch_async(dispatch_get_main_queue(), {
                        notice.labelText = "登陆失败"
                        notice.hide(true, afterDelay: 5)
                    })
                default:
                    println("???")
                    dispatch_async(dispatch_get_main_queue(), {
                        notice.labelText = "登陆失败"
                        notice.hide(true, afterDelay: 5)
                    })
                }
                
            }
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
