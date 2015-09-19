//
//  MainTabBar.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/18.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers![1].tabBarItem.badgeValue = "5"
        
        YunBaService.setAlias(userId, resultBlock: { (succ: Bool, error: NSError!) -> Void in
            if (succ) {
                print("注册用户名成功")
            }
            else {
                print("注册用户名失败")
            }
        })
        YunBaService.subscribe("iOS", resultBlock: { (succ: Bool, error: NSError!) -> Void in
            if (succ) {
                print("订阅成功")
            }
            else {
                print("订阅失败")
            }
        })
        
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
