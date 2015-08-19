//
//  PhotoCollectionViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/13.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftHTTP
import JSONJoy

let reuseIdentifier = "PhotoCell"
var imgUri = [String]()

class PhotoCollectionViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var PhotoList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var request = HTTPTask()
        request.GET(serverAddress + "/album/\(album[selectedAlbumIndex].id!)/list", parameters: nil) { (response: HTTPResponse) -> Void in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                println("以获取照片列表")
                let resp = AlbumList(JSONDecoder(obj))
                imgUri.removeAll(keepCapacity: false)
                var temp:Array<AlbumListData>! = resp.data
                
                for (var i = 0; i < temp!.count; i++) {
                    imgUri.append(temp[i].thumbUri!)
                }
                dispatch_async(dispatch_get_main_queue(), {self.PhotoList.reloadData()})
                println("AlbumData count: \(imgUri.count)")
            }
        }

//        println("\(selectedAlbum.data.)")
        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        imgUri.removeAll(keepCapacity: false)
        self.PhotoList.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        //#warning Incomplete method implementation -- Return the number of sections
//        return 0
//    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        
        return imgUri.count
        
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoThumbCollectionViewCell
        cell.PhotoThumbImage.kf_setImageWithURL(NSURL(string: imgUri[indexPath.row])!)
        // Configure the cell
        println(imgUri[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let picDimension :CGFloat = self.view.frame.width / 4.0
//        println(self.view.frame.width)
//        println(picDimension)
        return CGSizeMake(picDimension, picDimension)
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let leftRightInset = self.view.frame.size.width / 14.0
        
        let topInset = self.view.frame.height / 25.0
        return UIEdgeInsetsMake(topInset, leftRightInset, topInset, leftRightInset)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 40
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
