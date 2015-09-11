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
    
    func config(task: Task) {
        self.thumbnailImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        self.thumbnailImageView?.clipsToBounds = true
        self.titleLabel?.text = task.title
        self.timeLabel?.text = task.workTime
        self.priceLabel?.text = task.price == "0" ? "价格面议" : task.price
        self.locationLabel?.text = task.address
        self.statusLabel?.text = task.isAllowed ? "报名中" : "已结束"
        if (task.imgUri != nil){
            self.thumbnailImageView?.kf_setImageWithURL(NSURL(string: task.imgUri!)!)
        }
    }
}
