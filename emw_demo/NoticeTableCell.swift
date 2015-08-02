//
//  NoticeTableCell.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import Foundation
import UIKit

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
}
