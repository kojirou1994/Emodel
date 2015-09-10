//
//  ButtonTableViewCell.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/10.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var signUpBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
