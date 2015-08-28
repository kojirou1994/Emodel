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

class LoginViewController: UIViewController {

    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var mobileInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBAction func loginBtnPressed(sender: AnyObject) {
        var request = HTTPTask()
        let params: Dictionary<String,AnyObject> = ["username": mobileInput.text, "password": passwordInput.text,"autoLogin": "1"]
        request.POST(serverAddress + "/user/login", parameters: params, completionHandler: {(response: HTTPResponse) in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
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
                    self.dismissViewControllerAnimated(false, completion: nil)
                case 400:
                    println("error")
                default:
                    println("???")
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
