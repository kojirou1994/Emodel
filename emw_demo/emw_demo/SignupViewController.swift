//
//  SignupViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/7.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

class SignupViewController: UIViewController {
    
    var countDownTimer:NSTimer?  //计时器
    var timeNum:Int = 60 //验证码重发60秒
    var token: String = ""
    var userId: String = ""
    var confirmToken:String = ""
    
    @IBOutlet weak var mobileInput: UITextField!
    
    @IBOutlet weak var codeInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var passwordConfirmInput: UITextField!
    
    @IBOutlet weak var sendMobileBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sendMobileBtnPressed(sender: AnyObject) {
        if count(mobileInput.text) == 11 {
            var request = HTTPTask()
            sendMobileBtn.userInteractionEnabled = false
            self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
            let params: Dictionary<String,AnyObject> = ["mobile": mobileInput.text]
            //        ["param": "param1", "array": ["first array element","second","third"], "num": 23, "dict": ["someKey": "someVal"]]
            println("\(serverAddress)/user/confirm")
            request.POST("\(serverAddress)/user/confirm", parameters: params, completionHandler: {(response: HTTPResponse) in
                //do things...
                if let err = response.error {
                    println("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                else if let obj: AnyObject = response.responseObject {
                    let resp = ConfirmResp(JSONDecoder(obj))
                    println("status is: \(resp.status!)")
                    println("confirm token is:\(resp.data!.confirm_token!)")
                    self.confirmToken = resp.data!.confirm_token!
                }
            })
        }
        else{
            //send phone number error
            var alert = UIAlertController(title: "号码不正确", message: "请输入正确的手机号", preferredStyle: UIAlertControllerStyle.Alert)
            var actionYes = UIAlertAction(title: "返回", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(actionYes)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func registerBtnPressed(sender: AnyObject) {
        if isEmpty(codeInput.text) || isEmpty(passwordInput.text) || isEmpty(passwordConfirmInput.text) {
            //send error
            var alert = UIAlertController(title: "填写不正确", message: "请输入正确的信息", preferredStyle: UIAlertControllerStyle.Alert)
            var actionYes = UIAlertAction(title: "返回", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(actionYes)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            var request = HTTPTask()
            let params: Dictionary<String,AnyObject> = ["mobile": mobileInput.text, "password": passwordInput.text, "confirm_token": self.confirmToken, "confirm": codeInput.text]

            request.POST("\(serverAddress)/user/signup", parameters: params, completionHandler: {(response: HTTPResponse) in
                if let err = response.error {
                    println("error: \(err.localizedDescription)")
                    return
                }
                else if let obj: AnyObject = response.responseObject {
                    let resp = ConfirmResp(JSONDecoder(obj))
                }
            })
        }
    }
    
    func updateTimer(){
        timeNum--
        if timeNum == 0 {
            countDownTimer?.invalidate()
            timeNum = 60
            sendMobileBtn.userInteractionEnabled = true
            self.sendMobileBtn.titleLabel?.text = "SEND"
            self.sendMobileBtn.setTitle("SEND", forState: UIControlState.Normal)
        }
        else{
            self.sendMobileBtn.titleLabel?.text = "SENDED\(timeNum)"
            self.sendMobileBtn.setTitle("SENDED\(timeNum)", forState: UIControlState.Normal)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileInput.keyboardType = UIKeyboardType.PhonePad
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        println(textField.text)
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.beginAnimations("Animation", context: nil)
        UIView.setAnimationDuration(0.20)
        UIView.setAnimationBeginsFromCurrentState(true)
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 100, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.beginAnimations("Animation", context: nil)
        UIView.setAnimationDuration(0.20)
        UIView.setAnimationBeginsFromCurrentState(true)
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 100, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
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
