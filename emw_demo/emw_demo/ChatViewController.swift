//
//  ChatViewController.swift
//  Yunba
//
//  Created by 王宇 on 15/9/11.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var chatTableView: UITableView!
    
    var targetUserID: String!
    
    var inputKeyView: UIView!
    var inputField: UITextField!
    var sendBtn: UIButton!
    
    var chatLog: Array<Dictionary<String, AnyObject>>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initChatDatabase()
        print("聊天对象id： \(targetUserID)")
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = userNameAndAvatarStorage[targetUserID]!["NickName"]
        
        chatTableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-45)
        
        inputKeyView = UIView(frame: CGRectMake(0, self.view.frame.height-45, self.view.frame.width, 45))
        inputKeyView.backgroundColor = UIColor.lightGrayColor()
//        (red: 218, green: 218, blue: 218, alpha: 1)
//            .grayColor()
        
        inputField = UITextField(frame: CGRectMake(5, 5, 250, 35))
        inputField.tag = 0
//        inputField.delegate = self
        inputField.backgroundColor = UIColor.whiteColor()
        inputField.borderStyle = UITextBorderStyle.RoundedRect
        inputKeyView.addSubview(inputField)
        
        sendBtn = UIButton(type: UIButtonType.RoundedRect)
        sendBtn.frame = CGRectMake(260, 5, 55, 35)
        sendBtn.setTitle("发送", forState: UIControlState.Normal)
//        sendBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        sendBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
//        sendBtn.backgroundColor = UIColor.blackColor()
        sendBtn.addTarget(self, action: "send", forControlEvents: UIControlEvents.TouchUpInside)
        inputKeyView.addSubview(sendBtn)
        
        self.view.addSubview(inputKeyView)
        
        let profileBtn = UIBarButtonItem(title: "Profile", style: UIBarButtonItemStyle.Plain, target: self, action: "pushToProfileVC")
        self.navigationItem.rightBarButtonItem = profileBtn
        self.chatTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        self.addNotificationHandler()
        self.goToLatestMessage()
    }
    
    func initChatDatabase() {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetch = NSFetchRequest(entityName: "Chat")
        let pre = NSPredicate(format: "localUserId = %@ AND remoteUserId = %@", userId,targetUserID)
        fetch.predicate = pre
        var db: [AnyObject]?
        do {
            db = try context.executeFetchRequest(fetch)
        } catch let fetchError as NSError {
            print("retrieveAllItems error: \(fetchError.localizedDescription)")
        }
        chatLog = Array<Dictionary<String, AnyObject>>()
        for i in db! {
//            print(i)
            chatLog?.append(["isFromSelf": i.valueForKey("isFromSelf") as! Bool, "messageType": i.valueForKey("messageType") as! Int, "time": i.valueForKey("time") as! NSDate, "content": i.valueForKey("content") as! String])
        }
    }
    
    func send() {
        guard let inputM = inputField.text else {
            self.showSimpleAlert("警告", message: "消息不能为空")
            return
        }
        let sendTime = NSDate()
        //        self.inputField.resignFirstResponder()
        
        //输入完先添加消息框
        inputField.text = nil
        //添加数据至chatlog
        chatLog?.append(["isFromSelf": true, "messageType": 1, "time": sendTime, "content": inputM])
//        self.chatTableView.reloadData()
        let insert = NSIndexPath(forRow: chatLog!.count - 1, inSection: 0)
        self.chatTableView.insertRowsAtIndexPaths([insert], withRowAnimation: UITableViewRowAnimation.Right)
        self.goToLatestMessage()
        //预处理发送消息
        let sendM = "{\"fromUserId\":\"\(userId)\",\"messageType\":1,\"messageContent\":\"\(inputM)\"}"
        //保存消息到数据库
        saveMessageToDatabase(userId, remoteUserId: targetUserID, messageType: 1, isFromSelf: true, time: sendTime, messageContent: inputM)
        
        recentChatList[self.targetUserID] = ["time": sendTime,
            "message": inputM
        ]
        unReadCount[self.targetUserID] = 0
        recentChatList.writeToFile(recentChatPlist!, atomically: true)
        NSNotificationCenter.defaultCenter().postNotificationName("updateChatListVC", object: self)
        
        YunBaService.publishToAlias(targetUserID, data: sendM.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true), option: YBPublishOption(qos: YBQosLevel.Level1, retained: false)) { (succ: Bool, error: NSError!) -> Void in
            if (succ) {
                print("聊天信息已发送")
            }
            else {
                print("聊天信息发送失败")
                print(error.description)
            }
        }
    }
    
    //MARK : - YunbaService
    func addNotificationHandler() {
        let defaultNC = NSNotificationCenter.defaultCenter()
        defaultNC.addObserver(self, selector: "onMessageReceived:", name: kYBDidReceiveMessageNotification, object: nil)
        defaultNC.addObserver(self, selector: "onPresenceReceived", name: kYBDidReceivePresenceNotification, object: nil)
        defaultNC.addObserver(self, selector: "keyboardWillAppear:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        defaultNC.addObserver(self, selector: "keyboardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }
    func removeNotificationHandler() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func onMessageReceived(notification: NSNotification) {
        let message: YBMessage = notification.object as! YBMessage
        if (YunbaChatMessage(JSONDecoder(message.data)).fromUserId == targetUserID) {
            //添加数据至chatlog
            chatLog?.append(["isFromSelf": false, "messageType": 1, "time": NSDate(), "content": YunbaChatMessage(JSONDecoder(message.data)).messageContent])
            self.chatTableView.reloadData()
            self.goToLatestMessage()
        }
        
    }
    
    func onPresenceReceived(notification: NSNotification) {
        let presence: YBPresenceEvent = notification.object as! YBPresenceEvent
        print("new presence, action = \(presence.action), topic = \(presence.topic), alias = \(presence.alias), time = \(presence.time)")
    }
    
    func keyboardWillAppear(notification: NSNotification) {
        let kbHeight = self.keyboardEndingFrameHeight(notification.userInfo!)
        
        self.inputKeyView.frame = CGRectMake(0, self.view.frame.height - kbHeight - 45, self.inputKeyView.frame.size.width, 45)
        self.chatTableView.frame = CGRectMake(0, 0, self.chatTableView.frame.size.width, self.view.frame.size.height - kbHeight - 45)
        print(self.inputKeyView.frame)
        self.goToLatestMessage()
    }
    
    func keyboardWillDisappear(notification: NSNotification) {
        let kbHeight = self.keyboardEndingFrameHeight(notification.userInfo!)
        self.chatTableView.frame = CGRectMake(self.chatTableView.frame.origin.x, self.chatTableView.frame.origin.y, self.chatTableView.frame.size.width, self.chatTableView.frame.size.height + kbHeight)
        self.inputKeyView.frame = CGRectMake(0, self.view.frame.height-45, self.view.frame.width, 45)
        print(self.inputKeyView.frame)
        self.goToLatestMessage()
    }
    func keyboardEndingFrameHeight(userinfo: NSDictionary) -> CGFloat{
        let keyboardEndingUncorrectedFrame = userinfo.objectForKey(UIKeyboardFrameEndUserInfoKey)!.CGRectValue
        let keyboardEndingFrame = self.view.convertRect(keyboardEndingUncorrectedFrame, fromView: nil)
        return keyboardEndingFrame.size.height
    }
    
    func pushToProfileVC() {
        print("显示用户简介")
    }
    
    func goToLatestMessage() {
        if (self.chatLog != nil && self.chatLog!.count > 0) {
            let index = NSIndexPath(forRow: (self.chatLog?.count)! - 1, inSection: 0)
            chatTableView.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        currentChatUserId = targetUserID
        goToLatestMessage()
    }
    override func viewWillDisappear(animated: Bool) {
        currentChatUserId = nil
//        self.removeNotificationHandler()
    }

    func bubbleView(text: String, fromSelf: Bool, position: Int) -> UIView {
        //计算大小
        let font = UIFont.systemFontOfSize(14)
        let str = NSString(string: text)
        let size = str.boundingRectWithSize(CGSizeMake(180, 20000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        let returnView = UIView(frame: CGRectZero)
        returnView.backgroundColor = UIColor.clearColor()
        
        //背景图片
        let bubble = UIImage(named: (fromSelf ? "SenderAppNodeBkg_HL.png" : "ReceiverTextNodeBkg.png"))
        let bubbleImageView = UIImageView(image: bubble!.stretchableImageWithLeftCapWidth(Int(bubble!.size.width / 2), topCapHeight: Int(bubble!.size.height / 2)))
        print(size.width)
        print(size.height)
        
        //添加文本
        let bubbleText = UILabel(frame: CGRectMake(fromSelf ? 15.0 : 22.0, 20.0, size.width+10, size.height+10))
        bubbleText.backgroundColor =  UIColor.clearColor()
        bubbleText.font = font
        bubbleText.numberOfLines = 0
        bubbleText.lineBreakMode = NSLineBreakMode.ByWordWrapping
        bubbleText.text = text
        
        bubbleImageView.frame = CGRectMake(0.0, 14.0, bubbleText.frame.size.width + 30.0, bubbleText.frame.size.height + 20.0)
        
        if (fromSelf) {
            returnView.frame = CGRectMake(CGFloat(CGFloat(320 - position) - (bubbleText.frame.size.width + 30)), CGFloat(0), bubbleText.frame.size.width + 30, bubbleText.frame.size.height + 30)
        }
        else {
            returnView.frame = CGRectMake(CGFloat(position), CGFloat(0), bubbleText.frame.size.width + 30, bubbleText.frame.size.height + 30)
            
        }
        returnView.addSubview(bubbleImageView)
        returnView.addSubview(bubbleText)
        return returnView
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatLog == nil ? 0 : chatLog!.count
    }
    var str:Array<String> = ["开始聊天"]
    var isFromSelf: Array<Bool> = [true]

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("chatDetailCell") else {
            return UITableViewCell()
        }
        for i in cell.subviews {
            i.removeFromSuperview()
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        var head: UIImageView
        if (chatLog![indexPath.row]["isFromSelf"] as! Bool) {
            //来自自己的消息，用本地用户头像
            head = UIImageView(frame: CGRectMake(320 - 60, 10, 50, 50))
            cell.addSubview(head)
            head.kf_setImageWithURL(NSURL(string: (localUser.baseInfo?.avatar)!)!)
            roundHead(head)
            cell.addSubview(bubbleView(chatLog![indexPath.row]["content"] as! String, fromSelf: true, position: 65))
//            print("cell \(indexPath.row) head1 added")
        }
        else {
            head = UIImageView(frame: CGRectMake(10, 10, 50, 50))
            cell.addSubview(head)
            head.kf_setImageWithURL(NSURL(string: userNameAndAvatarStorage[targetUserID]!["AvatarAddress"]!)!)
            roundHead(head)
            cell.addSubview(bubbleView(chatLog![indexPath.row]["content"] as! String, fromSelf: false, position: 65))
//            print("cell \(indexPath.row) head2 added")
        }
        print("cell \(indexPath.row) loaded")
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let font = UIFont.systemFontOfSize(14)
        let text = chatLog![indexPath.row]["content"] as! NSString
        let size = text.boundingRectWithSize(CGSizeMake(180, 20000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil)
        return size.height + 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func roundHead(img: UIImageView) {
        img.layer.masksToBounds = true
        img.layer.cornerRadius = img.bounds.width / 2
//        img.layer.bor
    }
    
    //MARK: - TextFieldDelegate
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        UIView.beginAnimations("Animation", context: nil)
//        UIView.setAnimationDuration(0.2)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        self.chatTableView.frame = CGRectMake(self.chatTableView.frame.origin.x, self.chatTableView.frame.origin.y, self.chatTableView.frame.size.width, self.chatTableView.frame.size.height - 250)
//        self.inputKeyView.frame = CGRectMake(self.inputKeyView.frame.origin.x, self.inputKeyView.frame.origin.y - 250, self.inputKeyView.frame.size.width, self.inputKeyView.frame.size.height)
//        
//        UIView.commitAnimations()
//    }
//    
//    func textFieldDidEndEditing(textField: UITextField) {
//        UIView.beginAnimations("Animation", context: nil)
//        UIView.setAnimationDuration(0.2)
//        UIView.setAnimationBeginsFromCurrentState(true)
//        self.chatTableView.frame = CGRectMake(self.chatTableView.frame.origin.x, self.chatTableView.frame.origin.y, self.chatTableView.frame.size.width, self.chatTableView.frame.size.height + 250)
//        self.inputKeyView.frame = CGRectMake(self.inputKeyView.frame.origin.x, self.inputKeyView.frame.origin.y + 250, self.inputKeyView.frame.size.width, self.inputKeyView.frame.size.height)
//        UIView.commitAnimations()
//    }
    
}
