//
//  ChatViewController.swift
//  Yunba
//
//  Created by 王宇 on 15/9/11.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    var str = ["你好","你也好","还钱","..........................................................................................长文本","超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本超长文本"]
    
    var usertype = true
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row % 2 == 0) {
            usertype = false
        }
        else {
            usertype = true
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("chatDetailCell") as! UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        var head: UIImageView
        if (usertype) {
            head = UIImageView(frame: CGRectMake(320 - 60, 10, 50, 50))
            cell.addSubview(head)
            head.image = UIImage(named: "photo1")
            roundHead(head)
            cell.addSubview(bubbleView(str[indexPath.row], fromSelf: true, position: 65))
        }
        else {
            head = UIImageView(frame: CGRectMake(10, 10, 50, 50))
            cell.addSubview(head)
            head.image = UIImage(named: "head.jpg")
            roundHead(head)
            cell.addSubview(bubbleView(str[indexPath.row], fromSelf: false, position: 65))
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let font = UIFont.systemFontOfSize(14)
        let text = str[indexPath.row] as NSString
        let size = text.boundingRectWithSize(CGSizeMake(180, 20000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil)
        return size.height + 44
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func roundHead(img: UIImageView) {
        img.layer.masksToBounds = true
        img.layer.cornerRadius = img.bounds.width / 2
//        img.layer.bor
    }
}
