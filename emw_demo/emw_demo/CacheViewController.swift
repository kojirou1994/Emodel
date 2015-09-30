//
//  CacheViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/29.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import Kingfisher

class CacheViewController: UIViewController {

    @IBAction func clearCache(sender: AnyObject) {
        KingfisherManager.sharedManager.cache.clearDiskCache()
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBOutlet weak var clearCacheButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        clearCacheButton.layer.masksToBounds = true
        clearCacheButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
