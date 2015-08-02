//
//  NoticeDetailTableCellTableViewCell.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class NoticeDetailTableCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var propLabel: UILabel?

    
    func configurateTheCell(detail: NoticeDetailForm) {
        self.titleLabel?.text = detail.title
        self.propLabel?.text = detail.prop
    }
}
