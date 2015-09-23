//
//  ChatListTableViewCell.swift
//  Yunba
//
//  Created by 王宇 on 15/9/11.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var latestMessageLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var badgeLabel: SwiftBadge!
    
    func configTheCell(badge: Int) {
        if (badge <= 0) {
            badgeLabel.hidden = true
            return
        }
        else {
            badgeLabel.hidden = false
            badgeLabel.text = String(badge)
            let bd = SwiftBadge()
            bd.text = String(badge)
//            bd.textColor
            self.badgeLabel.addSubview(bd)
        }
    }
    
}
