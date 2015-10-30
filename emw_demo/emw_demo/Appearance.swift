//
//  File.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/20.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func setTabbarColor() {
        guard let tabbar = self.window?.rootViewController as? UITabBarController else {
            return
        }
        tabbar.tabBar.tintColor = UIColor(hexString: "#ff3f85")!
        tabbar.tabBar.backgroundColor = UIColor.whiteColor()
    }
    
}