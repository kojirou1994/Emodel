//
//  ModalCollectionViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/26.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import Alamofire

class ModalCollectionViewController: UICollectionViewController {

    var modalData: Ad?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.loadUsers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ToModalProfile") {
            let mpvc = segue.destinationViewController as! ModalProfileTableViewController
            let index = self.collectionView?.indexPathsForSelectedItems()
            mpvc.targetUserId = modalData?.users![(index?.first?.row)!]
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return modalData == nil ? 0 : (modalData?.users?.count)!
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ModalCell", forIndexPath: indexPath) as! ModalCollectionViewCell
        cell.configTheCell((modalData?.users![indexPath.row])!)
        // Configure the cell
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let picDimension: CGFloat = ( self.view.frame.width - 40) / 3
        print("size setted")
        return CGSizeMake(picDimension, picDimension)
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension ModalCollectionViewController {
    func loadUsers() {
        Alamofire.request(.GET, "http://api.emwcn.com/ad")
        .validate()
        .responseJSON { (_, _, result) -> Void in
            switch result {
            case .Failure(_, let err):
                print(err)
            case .Success(_):
                self.modalData = Ad(JSONDecoder(result.value!))
                print(self.modalData)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.collectionView?.reloadData()
                })
            }
        }
    }
}
