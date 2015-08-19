//
//  WelcomePageViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/7.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit


class WelcomePageViewController: UIViewController, UIScrollViewDelegate {
    var pageControll: UIPageControl!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!

    @IBAction func loginBtnPressed(sender: AnyObject) {
    }
    
    @IBAction func signupBtnPressed(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLogin {
            loginBtn.hidden = true
            signupBtn.hidden = true
        }
        else {
            //没登录展示介绍界面
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
            self.view.addSubview(scrollView)
            
            println("\(scrollView.contentOffset)")
            
            pageControll = UIPageControl(frame: CGRectMake(self.view.frame.width/2-20, self.view.frame.height-100, 40, 37))
            pageControll.numberOfPages = 3
            pageControll.currentPage = 0
            self.view.addSubview(pageControll)
            //按钮到上层来
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
        if isLogin {
        //弄个动画
            self.performSegueWithIdentifier("showMainTab", sender: self)
        }
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
