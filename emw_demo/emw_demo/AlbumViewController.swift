//
//  AlbumViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/13.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftHTTP
import JSONJoy
import MWPhotoBrowser

var AlbumData: Array<AlbumList> = Array<AlbumList>()
var selectedAlbum: AlbumList = AlbumList()

var selectedAlbumIndex:Int = 0
var photos: NSMutableArray = []
var thumbs: NSMutableArray = []
class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, MWPhotoBrowserDelegate {
    
    @IBOutlet weak var AlbumListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in AlbumListCollectionView.visibleCells() {
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = AlbumListCollectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AlbumThumbCollectionViewCell
        cell.AlbumTitle.text = album[indexPath.row].name!
        cell.ThumbImage.contentMode = UIViewContentMode.ScaleAspectFill
        cell.ThumbImage.clipsToBounds = true
        cell.ThumbImage.kf_setImageWithURL(NSURL(string: album[indexPath.row].imgUri!)!)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var request = HTTPTask()
        photos.removeAllObjects()
        thumbs.removeAllObjects()
        request.GET(serverAddress + "/album/\(album[indexPath.row].id!)/list", parameters: nil) { (response: HTTPResponse) -> Void in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                println("已获取照片列表地址")
                let resp = AlbumList(JSONDecoder(obj))
//                imgUri.removeAll(keepCapacity: false)
                photos.removeAllObjects()
                thumbs.removeAllObjects()
                for i in resp.data! {
                    photos.addObject(MWPhoto(URL: NSURL(string: i.imgUri)!))
                    thumbs.addObject(MWPhoto(URL: NSURL(string: i.thumbUri!)!))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    var pb = MWPhotoBrowser()
                    var pb2 = PhotoBrowserViewController(photos: photos as [AnyObject])
                    self.navigationController?.pushViewController(pb2, animated: true)
                })
            }
        }
        
    }
    
    
    
    func showPhotoBrowser() {
        var browser = MWPhotoBrowser(delegate: self)
        
        // Set options
        browser.displayActionButton = true // Show action button to allow sharing, copying, etc (defaults to YES)
        browser.displayNavArrows = false // Whether to display left and right nav arrows on toolbar (defaults to NO)
        browser.displaySelectionButtons = false // Whether selection buttons are shown on each image (defaults to NO)
        browser.zoomPhotosToFill = true // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
        browser.alwaysShowControls = false // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
        browser.enableGrid = true // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
        browser.startOnGrid = true // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
        
        self.navigationController?.pushViewController(browser, animated: true)

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let picDimension :CGFloat = self.view.frame.width / 8.0 * 3
        println(self.view.frame.width)
        println(picDimension)
        return CGSizeMake(picDimension, picDimension / 4 * 5)
        
    }
    

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let leftRightInset = self.view.frame.size.width / 14.0
        
        let topInset = self.view.frame.height / 25.0
        return UIEdgeInsetsMake(topInset, leftRightInset, topInset, leftRightInset)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 40
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
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, thumbPhotoAtIndex index: UInt) -> MWPhotoProtocol! {
        if ((Int)(index) < thumbs.count) {
            return thumbs.objectAtIndex(Int(index)) as! MWPhoto
        }
        return nil
    }
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, photoAtIndex index: UInt, selectedChanged selected: Bool) {
        if selected {
            println("photo \(index) selected")
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
