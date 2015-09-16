//
//  AppDelegate.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

let appkey = "55ef96c14a481fa955f39232"
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        readUserData()
        localUser = UserData()
        YunBaService.setupWithAppkey(appkey)
        kYBLogLevel = .Debug
        if (NSString(string: UIDevice.currentDevice().systemVersion).floatValue >= 8.0) {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound | UIUserNotificationType.Badge, categories: nil))
            UIApplication.sharedApplication().registerForRemoteNotifications()
        }
        else {
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(UIRemoteNotificationType.Sound | UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert)
        }
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func clearBadgeAndNotifications() {
        if (UIApplication.sharedApplication().applicationIconBadgeNumber > 0) {
            UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        println("get Device Token: \(deviceToken)")
        // uncomment to store device token to YunBa
        YunBaService.storeDeviceToken(deviceToken, resultBlock: { (succ: Bool, error: NSError!) -> Void in
            if (succ) {
                println("store device token to YunBa succ")
            }
            else {
                println("store device token to YunBa failed due to : \(error), recovery suggestion: \(error.localizedRecoverySuggestion)")
            }
        })
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println("didFailToRegisterForRemotenotificationWithError")
    }
}

