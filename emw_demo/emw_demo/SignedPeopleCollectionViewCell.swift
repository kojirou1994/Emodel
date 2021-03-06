//
//  SignedPeopleCollectionViewCell.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/22.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class SignedPeopleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    
    func setAvatarImage(id: String) {
        avatar.clipsToBounds = true
        DataManager.readUserData(id) { (succ, result) -> Void in
            if (succ) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.avatar.kf_setImageWithURL(NSURL(string: result[1])!)
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
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.avatar.kf_setImageWithURL(NSURL(string: (data?.baseInfo?.avatar)!)!)
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
