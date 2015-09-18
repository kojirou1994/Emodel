//
//  SignupViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/7.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    var countDownTimer:NSTimer?  //计时器
    var timeNum:Int = 60 //验证码重发60秒
    
    var confirmToken:String?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mobileInput: UITextField!
    
    @IBOutlet weak var codeInput: UITextField!
    
    @IBOutlet weak var userNameInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var passwordConfirmInput: UITextField!
    
    @IBOutlet weak var sendMobileBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sendMobileBtnPressed(sender: AnyObject) {
        self.view.endEditing(true)
        guard let mobileText = mobileInput.text else {
            showSimpleAlert("", message: "")
            return
        }
        if mobileText.characters.count == 11 {
            sendMobileBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            
            sendMobileBtn.userInteractionEnabled = false
            self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
            Alamofire.request(.POST, serverAddress + "/user/confirm", parameters: ["mobile": mobileText], encoding: ParameterEncoding.JSON, headers: nil)
                .validate()
                .responseJSON { _, _, result in
                    switch result {
                    case .Success:
                        let resp = ConfirmResp(JSONDecoder(result.value!))
                        print("status is: \(resp.status!)")
                        print("confirm token is:\(resp.data!.confirm_token!)")
                        self.confirmToken = resp.data!.confirm_token!
                    case .Failure(_, let error):
                        print("error")

                    }
            }
        }
        else{
            showSimpleAlert("手机号不正确", message: "请输入正确的手机号")
        }
    }
    
    @IBAction func registerBtnPressed(sender: AnyObject) {
        guard let mobileText = mobileInput.text else {
            showSimpleAlert("", message: "")
            return
        }
        guard let codeText = codeInput.text else {
            showSimpleAlert("", message: "")
            return
        }
        guard let passwordText = passwordInput.text else {
            showSimpleAlert("", message: "")
            return
        }
        guard let confirmPasswordText = passwordConfirmInput.text else {
            showSimpleAlert("", message: "")
            return
        }
        guard let usernameText = userNameInput.text else {
            showSimpleAlert("", message: "")
            return
        }
        guard let confirmTokenText = confirmToken else {
            showSimpleAlert("", message: "")
            return
        }
        Alamofire.request(.POST, serverAddress + "/user/signup", parameters: ["mobile": mobileText, "password": passwordText, "confirm_token": confirmTokenText, "confirm": codeText, "username": usernameText], encoding: ParameterEncoding.JSON, headers: nil)
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    let resp = ConfirmResp(JSONDecoder(result.value!))
                    self.dismissViewControllerAnimated(true, completion: nil)
                case .Failure(_, let error):
                    print(error)
                }
        }
    }
    
    func updateTimer(){
        timeNum--
        if timeNum == 0 {
            countDownTimer?.invalidate()
            timeNum = 60
            sendMobileBtn.userInteractionEnabled = true
            sendMobileBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            self.sendMobileBtn.titleLabel?.text = "发送验证码"
            self.sendMobileBtn.setTitle("发送验证码", forState: UIControlState.Normal)
        }
        else{
            self.sendMobileBtn.titleLabel?.text = "验证码已发送\(timeNum)"
            self.sendMobileBtn.setTitle("验证码已发送\(timeNum)", forState: UIControlState.Normal)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        mobileInput.delegate = self
        passwordInput.delegate = self
        passwordConfirmInput.delegate = self
        mobileInput.keyboardType = UIKeyboardType.PhonePad
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(textField.text)
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag == 5 {
        UIView.beginAnimations("Animation", context: nil)
        UIView.setAnimationDuration(0.20)
        UIView.setAnimationBeginsFromCurrentState(true)
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 100, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag == 5 {
        UIView.beginAnimations("Animation", context: nil)
        UIView.setAnimationDuration(0.20)
        UIView.setAnimationBeginsFromCurrentState(true)
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 100, self.view.frame.size.width, self.view.frame.size.height)
        UIView.commitAnimations()
        }
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
