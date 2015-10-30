//
//  ModalProfileTableViewCell.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/26.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ModalProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userAvatar.clipsToBounds = true
        self.userAvatar.layer.masksToBounds = true
        self.userAvatar.layer.cornerRadius = 64.5
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configTheCell(id: String) {
        DataManager.readUserData(id) { (succ, result) -> Void in
            if (succ) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.userNameLabel.text = result[0]
                    self.userAvatar.kf_setImageWithURL(NSURL(string: result[1] + "?imageMogr2/thumbnail/!250x250r/gravity/North/crop/250x250")!)
                })
            }
            else {
                Alamofire.request(.GET, serverAddress + "/user/\(id)")
                    .validate()
                    .responseJSON { _, _, result in
                        switch result {
                        case .Success:
                            let data = User(JSONDecoder(result.value!)).data
                            DataManager.saveUserData(id, nickName: data?.baseInfo?.nickName, avatarUrl: data?.baseInfo?.avatar)
                            dispatch_async(dispatch_get_main_queue(), {
                                self.userNameLabel.text = data?.baseInfo?.nickName
                                self.userAvatar.kf_setImageWithURL(NSURL(string: (data?.baseInfo?.avatar)! + "?imageMogr2/thumbnail/!250x250r/gravity/North/crop/250x250")!)
                            })
                        case .Failure(_, let error):
                            print(error)
                            return
                        }
                }
            }
        }
    }

}
