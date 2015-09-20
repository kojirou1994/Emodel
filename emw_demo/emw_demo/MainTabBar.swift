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
        print("start viewDidLoad")
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
        print("sleep 5s")
        sleep(5)
        print("viewDidLoad")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print("viewDidAppear")
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
