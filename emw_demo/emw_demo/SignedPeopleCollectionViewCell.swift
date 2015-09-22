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
    
    func setAvatarImage(userId: String) {
        print("start get Avatar Address")
//        self.avatar.contentMode = UIViewContentMode
        avatar.clipsToBounds = true
        Alamofire.request(.GET, serverAddress + "/user/\(userId)")
        .validate()
        .responseJSON { (_, _, result) -> Void in
            switch result {
            case .Success:
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print("Got Avatar")
                    print(User(JSONDecoder(result.value!)).data!.baseInfo!.avatar!)
                    self.avatar.kf_setImageWithURL(NSURL(string: User(JSONDecoder(result.value!)).data!.baseInfo!.avatar!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cache, imageURL) -> () in
                        print("Downloaded and set!")
                        print(image)
                        print(error)
                        print(self.avatar.frame)
                        print(self.frame)
                    })
                })
            case .Failure(_, let error):
                print("Failed to get Avatar")
                return
            }
        }
    }
}
