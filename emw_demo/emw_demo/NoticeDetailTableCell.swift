//
//  NoticeDetailTableCellTableViewCell.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class NoticeDetailTableCell: UITableViewCell {
    
    @IBOutlet weak var enrollBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.enrollBtn.layer.masksToBounds = true
        self.enrollBtn.layer.cornerRadius = 5
        // Initialization code
    }
}
