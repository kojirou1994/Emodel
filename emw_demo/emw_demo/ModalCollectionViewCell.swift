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
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    func configTheCell(id: String) {
        Alamofire.request(.GET, serverAddress + "/user/\(id)")
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    let uData = User(JSONDecoder(result.value!)).data
                    DataManager.saveUserData(id, nickName: (uData?.baseInfo?.nickName)!, avatarUrl: (uData?.baseInfo?.avatar)!)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.nickNameLabel.text = uData?.baseInfo?.nickName
                        self.priceLabel.text = "\(uData?.bodyInfo?.height == nil ? "??" : uData!.bodyInfo!.height!)cm／¥\(uData?.businessInfo?.inPrice == nil ? 0 : uData!.businessInfo!.inPrice!)"
                        //                                self.userNameLabel.text = data?.baseInfo?.nickName
                        self.avatarImage.kf_setImageWithURL(NSURL(string: (uData?.baseInfo?.avatar)! + "?imageMogr2/thumbnail/!250x250r/gravity/North/crop/250x250")!)
                    })
                case .Failure(_, let error):
                    print(error)
                    return
                }
        }
    }
}
