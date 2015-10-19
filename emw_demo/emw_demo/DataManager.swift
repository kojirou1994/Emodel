//
//  DataStorage.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/19.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import CoreData
class DataManager {
    class func saveUserData(userId: String, nickName: String, avatarUrl: String) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let row: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context)
        row.setValue(userId, forKey: "userId")
        row.setValue(nickName, forKey: "nickName")
        row.setValue(avatarUrl, forKey: "avatar")
        do {
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    class func readUserData(userId: String,completion: DMReadUserDataCompletionHandler) {
        print("fetching data for \(userId)")
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetch = NSFetchRequest(entityName: "User")
        let pre = NSPredicate(format: "userId = %@", userId)
        fetch.predicate = pre
        var db: [AnyObject]?
        do {
            db = try context.executeFetchRequest(fetch)
        } catch let fetchError as NSError {
            print("retrieveAllItems error: \(fetchError.localizedDescription)")
            completion(false,[])
            return
        }
        let i = db?.first
        guard let result = i else {
            print(db)
            completion(false,[])
            return
        }
        completion(true,[result.valueForKey("nickName")! as! String, result.valueForKey("avatar")! as! String])
    }
    
    class func saveMessageToDatabase(localUserId: String, remoteUserId: String, messageType: Int, isFromSelf: Bool, time: NSDate, messageContent: String) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let row: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Chat", inManagedObjectContext: context)
        row.setValue(messageContent, forKey: "content")
        row.setValue(isFromSelf, forKey: "isFromSelf")
        row.setValue(localUserId, forKey: "localUserId")
        row.setValue(messageType, forKey: "messageType")
        row.setValue(remoteUserId, forKey: "remoteUserId")
        row.setValue(time, forKey: "time")
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
public typealias DMReadUserDataCompletionHandler = (Bool, [String]) -> Void