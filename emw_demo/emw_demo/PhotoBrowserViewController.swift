//
//  PhotoBrowserViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/17.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import MWPhotoBrowser


class PhotoBrowserViewController: MWPhotoBrowser, MWPhotoBrowserDelegate, UINavigationBarDelegate {
    
    
    
    override func viewDidLoad() {
        self.displaySelectionButtons = true
        super.viewDidLoad()
        self.enableGrid = true
        println("Photo Browser showed")

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfPhotosInPhotoBrowser(photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(photos.count)
    }
    func photoBrowser(photoBrowser: MWPhotoBrowser!, photoAtIndex index: UInt) -> MWPhotoProtocol! {
        if ((Int)(index) < photos.count) {
            return photos.objectAtIndex(Int(index)) as! MWPhoto
        }
        return nil
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
