//
//  ModalCollectionViewCell.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/26.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ModalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func configTheCell(id: String) {
        DataManager.readUserData(id) { (succ, result) -> Void in
            if (succ) {
                dispatch_async(dispatch_get_main_queue(), {
//                    self.userNameLabel.text = result[0]
                    self.avatarImage.kf_setImageWithURL(NSURL(string: result[1] + "?imageMogr2/thumbnail/!250x250r/gravity/North/crop/250x250")!)
                })
            }
            else {
                Alamofire.request(.GET, serverAddress + "/user/\(id)")
                    .validate()
                    .responseJSON { _, _, result in
                        switch result {
                        case .Success:
                            let data = User(JSONDecoder(result.value!)).data
                            //                            updateUserNameAndAvatarStorage(id, name: (data?.baseInfo?.nickName)!, avatar: (data?.baseInfo?.avatar)!)
                            DataManager.saveUserData(id, nickName: (data?.baseInfo?.nickName)!, avatarUrl: (data?.baseInfo?.avatar)!)
                            dispatch_async(dispatch_get_main_queue(), {
//                                self.userNameLabel.text = data?.baseInfo?.nickName
                                self.avatarImage.kf_setImageWithURL(NSURL(string: (data?.baseInfo?.avatar)! + "?imageMogr2/thumbnail/!250x250r/gravity/North/crop/250x250")!)
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
