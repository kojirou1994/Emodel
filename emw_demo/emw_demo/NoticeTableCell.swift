//
//  NoticeTableCell.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
class NoticeTableCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var timeLabel: UILabel?
    @IBOutlet var priceLabel: UILabel?
    @IBOutlet var locationLabel: UILabel?
    @IBOutlet var statusLabel: UILabel?
    @IBOutlet var thumbnailImageView: UIImageView?
    
    
    func configurateTheCell(notice: Notice) {
        self.titleLabel?.text = notice.title
        self.timeLabel?.text = notice.time
        self.priceLabel?.text = notice.price
        self.locationLabel?.text = notice.location
        self.statusLabel?.text = notice.status
        self.thumbnailImageView?.image = UIImage(named: notice.thumbnails)
    }
    func config(task: Task) {
        self.thumbnailImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        self.thumbnailImageView?.clipsToBounds = true
        self.titleLabel?.text = task.title
        self.timeLabel?.text = task.workTime
        self.priceLabel?.text = task.price
        self.locationLabel?.text = task.address
        if (task.isAllowed) {
            self.statusLabel?.text = "报名中"
        }
        else {
            self.statusLabel?.text = "已结束"
        }
        if (task.imgUri != nil){
            self.thumbnailImageView?.kf_setImageWithURL(NSURL(string: task.imgUri!)!)
        }
    }
}
