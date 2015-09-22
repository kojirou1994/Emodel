//
//  ChatMessage.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/21.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import CoreData

class ChatMessage: NSManagedObject {
    @NSManaged var remoteUserId: String
    @NSManaged var messageType: Int
    @NSManaged var isFromSelf: Bool
    @NSManaged var content: String
    @NSManaged var time: NSDate
}