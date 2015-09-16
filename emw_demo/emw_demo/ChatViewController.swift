//
//  ChatViewController.swift
//  Yunba
//
//  Created by 王宇 on 15/9/11.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var chatTableView: UITableView!
    
    var targetUserID: String! = userId
    
    var inputKeyView: UIView!
    var inputField: UITextField!
    var sendBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "王羞羞"
        print(chatTableView.bounds)
        chatTableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-45)
        print(chatTableView.contentSize)
        
        inputKeyView = UIView(frame: CGRectMake(0, self.view.frame.height-45, self.view.frame.width, 45))
        inputKeyView.backgroundColor = UIColor.redColor()
        
        inputField = UITextField(frame: CGRectMake(5, 5, 260, 35))
        inputField.tag = 0
        inputField.delegate = self
        inputField.backgroundColor = UIColor.whiteColor()
        inputKeyView.addSubview(inputField)
        
        sendBtn = UIButton(frame: CGRectMake(260, 5, 55, 35))
        sendBtn.setTitle("发送", forState: UIControlState.Normal)
        sendBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sendBtn.backgroundColor = UIColor.blackColor()
        sendBtn.addTarget(self, action: "send", forControlEvents: UIControlEvents.TouchUpInside)
        inputKeyView.addSubview(sendBtn)
        
        self.view.addSubview(inputKeyView)
        
        let profileBtn = UIBarButtonItem(title: "Profile", style: UIBarButtonItemStyle.Plain, target: self, action: "pushToProfileVC")
        self.navigationItem.rightBarButtonItem = profileBtn
    }
    
    
    
    
    func send() {
        println("message sent")
        println(inputField.text)
        YunBaService.publishToAlias(targetUserID, data: inputField.text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true), option: YBPublishOption(qos: YBQosLevel.Level1, retained: false)) { (succ: Bool, error: NSError!) -> Void in
            if (succ) {
                self.str.append(self.inputField.text)
                self.chatTableView.reloadData()
            }
            else {
                
            }
        }
    }
    func pushToProfileVC() {
        println("显示用户简介")
    }
    func goToLatestMessage() {
        let index = NSIndexPath(forRow: str.count - 1, inSection: 0)
        chatTableView.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        goToLatestMessage()
    }
//    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
//        return nil
//    }
    
    func bubbleView(text: String, fromSelf: Bool, position: Int) -> UIView {
        //计算大小
        var font = UIFont.systemFontOfSize(14)
        var str = NSString(string: text)
        var size = str.boundingRectWithSize(CGSizeMake(180, 20000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        var returnView = UIView(frame: CGRectZero)
        returnView.backgroundColor = UIColor.clearColor()
        
        //背景图片
        var bubble = UIImage(named: (fromSelf ? "SenderAppNodeBkg_HL.png" : "ReceiverTextNodeBkg.png"))
        var bubbleImageView = UIImageView(image: bubble!.stretchableImageWithLeftCapWidth(Int(bubble!.size.width / 2), topCapHeight: Int(bubble!.size.height / 2)))
        println(size.width)
        println(size.height)
        
        //添加文本
        var bubbleText = UILabel(frame: CGRectMake(fromSelf ? 15.0 : 22.0, 20.0, size.width+10, size.height+10))
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
        return str.count
    }
    var str:Array<String> = ["","",""]
    
    var usertype = true
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        usertype = (indexPath.row % 2) == 0
        let cell = tableView.dequeueReusableCellWithIdentifier("chatDetailCell") as! UITableViewCell
        for i in cell.subviews {
            i.removeFromSuperview()
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        var head: UIImageView
        if (usertype) {
            head = UIImageView(frame: CGRectMake(320 - 60, 10, 50, 50))
            cell.addSubview(head)
            head.image = UIImage(named: "photo1")
            roundHead(head)
            cell.addSubview(bubbleView(str[indexPath.row], fromSelf: true, position: 65))
            println("celll \(indexPath.row) head1 added")
        }
        else {
            head = UIImageView(frame: CGRectMake(10, 10, 50, 50))
            cell.addSubview(head)
            head.image = UIImage(named: "head.jpg")
            roundHead(head)
            cell.addSubview(bubbleView(str[indexPath.row], fromSelf: false, position: 65))
            println("celll \(indexPath.row) head2 added")
        }
        println("celll \(indexPath.row) loaded")
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let font = UIFont.systemFontOfSize(14)
        let text = String(indexPath.row) as NSString
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.beginAnimations("Animation", context: nil)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationBeginsFromCurrentState(true)
        self.chatTableView.frame = CGRectMake(self.chatTableView.frame.origin.x, self.chatTableView.frame.origin.y - 250, self.chatTableView.frame.size.width, self.chatTableView.frame.size.height)
        self.inputKeyView.frame = CGRectMake(self.inputKeyView.frame.origin.x, self.inputKeyView.frame.origin.y - 250, self.inputKeyView.frame.size.width, self.inputKeyView.frame.size.height)
        
        UIView.commitAnimations()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.beginAnimations("Animation", context: nil)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationBeginsFromCurrentState(true)
        self.chatTableView.frame = CGRectMake(self.chatTableView.frame.origin.x, self.chatTableView.frame.origin.y + 250, self.chatTableView.frame.size.width, self.chatTableView.frame.size.height)
        self.inputKeyView.frame = CGRectMake(self.inputKeyView.frame.origin.x, self.inputKeyView.frame.origin.y + 250, self.inputKeyView.frame.size.width, self.inputKeyView.frame.size.height)
        
        UIView.commitAnimations()
    }
    
}
