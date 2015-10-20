//
//  CMTableViewCell.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/19.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit

class CMTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTimeLabel: UILabel!
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print(self.eventTimeLabel.frame)
        // Configure the view for the selected state
    }
    
}
