//
//  PhotoScrollViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/7.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoScrollViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var loadingview: UIView!
    
    var photoData:[AlbumListData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    func loadImage() {
        let numOfPages = 3
        let pageWidth = self.view.frame.width
        let pageHeight = self.view.frame.height
        for photo in photoData! {
            let iv = UIImageView(frame: CGRectMake(0, 0, pageWidth, pageHeight))
            iv.kf_setImageWithURL(NSURL(string: photo.imgUri)!, placeholderImage: nil, optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                if (error == nil) {
                    
                }
            })

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
