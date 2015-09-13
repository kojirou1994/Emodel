//
//  WelcomePageViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/7.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import SwiftHTTP
import MBProgressHUD
import JSONJoy

class WelcomePageViewController: UIViewController, UIScrollViewDelegate {
    var pageControll: UIPageControl!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var logoImage: UIImageView!
    var getDataCount = 0
    
    //展示特性的滚动视图
    func introduceScrollView() -> UIScrollView {
        let numOfPages = 3
        let pageWidth = self.view.frame.width
        let pageHeight = self.view.frame.height
        //scrollView的初始化
        var scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.frame = self.view.bounds
        //为了让内容横向滚动，设置横向内容宽度为3个页面的宽度总和
        scrollView.contentSize=CGSizeMake(CGFloat(pageWidth*CGFloat(numOfPages)), CGFloat(pageHeight))
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        //添加子页面
        for i in 0...numOfPages {
            var myViewController = SingleFeatureViewController(number:(i+1))
            myViewController.view.frame = CGRectMake(CGFloat(pageWidth*CGFloat(i)),
                CGFloat(0), CGFloat(pageWidth), CGFloat(pageHeight))
            scrollView.addSubview(myViewController.view)
        }
        return scrollView
    }
    
    func checkIsLogIn() {
        if isLogin {
            loadLoginView()
            tryGetUserData()
        }
        else {
            
        }
    }
    
    func tryGetUserData() {
        if (getDataCount == 2) {
            getDataCount = 0
            isLogin = false
            let notice = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            notice.labelText = "无法登陆"
            notice.hide(true, afterDelay: 0.5)
            dispatch_after(1, dispatch_get_main_queue(), {
                println("load login view")
                self.loadWelcomeView()
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = sb.instantiateViewControllerWithIdentifier("LogIn") as! LoginViewController
//                loginVC.mobileInput.text = username
                self.presentViewController(loginVC, animated: true, completion: nil)
                
            })
            return
        }
        else {
            getDataCount++
            //成功获取则为true
            var getUserInfo: Bool = false
            var getBaseInfo: Bool = false
            //获取失败为false
            var getUserInfoSuccess: Bool = true
            var getBaseInfoSuccess: Bool = true
            let notice = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            notice.labelText = getDataCount > 1 ? "重试中" : "获取数据中"
            var userInfoRequest = HTTPTask()
            userInfoRequest.GET(serverAddress + "/usr/\(userId!)", parameters: nil) { (response: HTTPResponse) -> Void in
                if let err = response.error {
                    println("error: \(err.localizedDescription)")
                    getUserInfoSuccess = false
                    if (!getBaseInfoSuccess) {
                        dispatch_async(dispatch_get_main_queue(), {
                            notice.hide(true)
                            self.tryGetUserData()
                        })
                    }
                    return
                }
                if let obj: AnyObject = response.responseObject {
                    let resp = User(JSONDecoder(obj))
                    println("success")
                    getUserInfo = true
                    if (getBaseInfo) {
                        var temp = localUser.baseInfo
                        localUser = resp.data
                        localUser.baseInfo = temp
                        println(localUser.baseInfo?.QQ)
                        println("从user进入")
                        dispatch_async(dispatch_get_main_queue(), {
                            self.transferToMainProgram()
                        })
                    }
                    else {
                        localUser = resp.data
                    }
                }
            }
            
            // baseinfo额外获取一次
            var baseInfoRequest = HTTPTask()
            baseInfoRequest.requestSerializer = HTTPRequestSerializer()
            baseInfoRequest.requestSerializer.headers["Token"] = token
            baseInfoRequest.GET(serverAddress + "/usr/\(userId!)/baseinfo", parameters: nil) { (response: HTTPResponse) -> Void in
                if let err = response.error {
                    println("error: \(err.localizedDescription)")
                    getBaseInfoSuccess = false
                    if (!getUserInfoSuccess) {
                        dispatch_async(dispatch_get_main_queue(), {
                            notice.hide(true)
                            self.tryGetUserData()
                        })
                    }
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
                        if (getBaseInfo && getUserInfo) {
                            println("从base进入")
                            dispatch_async(dispatch_get_main_queue(), {
                                self.transferToMainProgram()
                            })
                        }
                    }
                }
            }
        }
    }
    
    func transferToMainProgram() {
//        self.performSegueWithIdentifier("showMainTab", sender: self)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mainP = sb.instantiateViewControllerWithIdentifier("MainProgram") as! UITabBarController
        self.presentViewController(mainP, animated: true, completion: nil)
    }
    func loadWelcomeView() {
        loginBtn.hidden = false
        signupBtn.hidden = false
    }
    func loadLoginView() {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.setBackgroundImage(UIImage(named: "登陆Pressed"), forState: UIControlState.Highlighted)
        signupBtn.setBackgroundImage(UIImage(named: "注册Pressed"), forState: UIControlState.Highlighted)
        if isLogin {
            loginBtn.hidden = true
            signupBtn.hidden = true
        }
        else {
            //没登录展示介绍界面
            
//            pageControll = UIPageControl(frame: CGRectMake(self.view.frame.width/2-20, self.view.frame.height-100, 40, 37))
//            pageControll.numberOfPages = 3
//            pageControll.currentPage = 0
//            self.view.addSubview(pageControll)
            
            //按钮到上层来
            self.view.sendSubviewToBack(pageControll)
            self.view.bringSubviewToFront(signupBtn)
            self.view.bringSubviewToFront(loginBtn)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        println("出现啦\n \(isLogin)是否登录了")
        checkIsLogIn()
        //弄个动画
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var currentPage = Int(scrollView.contentOffset.x/self.view.frame.width)
        pageControll.currentPage = Int(currentPage)
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
