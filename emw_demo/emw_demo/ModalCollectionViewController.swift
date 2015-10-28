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
    //0-5
    @IBOutlet weak var modalTypeSegment: UISegmentedControl!
    @IBAction func modalTypeChanged(sender: AnyObject) {
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.loadUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ToModalProfile") {
            let mpvc = segue.destinationViewController as! ModalProfileTableViewController
            let index = self.collectionView?.indexPathsForSelectedItems()
            mpvc.targetUserId = modalData?.users(modalTypeSegment.selectedSegmentIndex)![(index?.first?.row)!]
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modalData?.users(modalTypeSegment.selectedSegmentIndex) == nil ? 0 : (modalData?.users(modalTypeSegment.selectedSegmentIndex)?.count)!
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ModalCell", forIndexPath: indexPath) as! ModalCollectionViewCell
        cell.configTheCell((modalData?.users(modalTypeSegment.selectedSegmentIndex)?[indexPath.row])!)
        // Configure the cell
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let picDimension: CGFloat = ( self.view.frame.width - 40) / 3
        print("size setted")
        return CGSizeMake(picDimension, picDimension * 1.45)
        
    }

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
