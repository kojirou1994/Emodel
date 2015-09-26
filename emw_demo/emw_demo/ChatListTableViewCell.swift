//
//  ChatListTableViewCell.swift
//  Yunba
//
//  Created by 王宇 on 15/9/11.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var latestMessageLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var badgeLabel: UILabel!
    
//    var uid:String?
    var round: Bool = false
    
    func configTheCell(badge: Int, id: String) {
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.cornerRadius = badgeLabel.frame.width / 2
        if (badge <= 0) {
            badgeLabel.hidden = true
        }
        else {
            badgeLabel.hidden = false
            badgeLabel.text = String(badge)
        }
//        if (self.uid != id) {
        if let cache = userNameAndAvatarStorage[id] {
            //有缓存数据，不获取
            self.userNameLabel.text = cache["NickName"]
            self.userAvatar.kf_setImageWithURL(NSURL(string: (cache["AvatarAddress"])!)!)
        }
        else {
            Alamofire.request(.GET, serverAddress + "/user/\(id)")
                .validate()
                .responseJSON { _, _, result in
                    switch result {
                    case .Success:
                        let data = User(JSONDecoder(result.value!)).data
                        updateUserNameAndAvatarStorage(id, name: (data?.baseInfo?.nickName)!, avatar: (data?.baseInfo?.avatar)!)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.userNameLabel.text = data?.baseInfo?.nickName
                            self.userAvatar.kf_setImageWithURL(NSURL(string: (data?.baseInfo?.avatar)!)!)
                        })
                    case .Failure(_, let error):
                        return
                    }
            }
        }

//        }

    }
    
}
