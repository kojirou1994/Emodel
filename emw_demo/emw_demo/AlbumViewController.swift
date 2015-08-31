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
class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    @IBAction func EditBtnPressed(sender: AnyObject) {
        println("show删除相册界面")
    }
    
    @IBOutlet weak var AlbumListCollectionView: UICollectionView!
    func addAlbum(barButton: UIBarButtonItem) {
        println("add pressed")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var addBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addAlbum:")
        self.navigationItem.rightBarButtonItem = addBtn
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - CllectionViewDelegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = AlbumListCollectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AlbumThumbCollectionViewCell
        cell.AlbumTitle.text = album[indexPath.row].name!
        cell.ThumbImage.contentMode = UIViewContentMode.ScaleAspectFill
        cell.ThumbImage.clipsToBounds = true
        cell.ThumbImage.kf_setImageWithURL(NSURL(string: album[indexPath.row].imgUri!)!)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("did Select\(indexPath)")
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let picDimension: CGFloat = self.view.frame.width / 32.0 * 13
        println("size: \(picDimension)")
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
    
    //MARK: - shouldPerformSegue
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "GoToAlbumDetail" {
            println("ShouldPerformSegue")
            sleep(2)
            return true
        }
        return true
    }
    
    // MARK: - prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToAlbumDetail" {
            println("prepareForSegue")
            let index = self.AlbumListCollectionView.indexPathsForSelectedItems()
            println("点击了相册 序号：")
            println(index)
            let destinationViewController: PhotoCollectionViewController = segue.destinationViewController as! PhotoCollectionViewController
            var request = HTTPTask()
            request.GET(serverAddress + "/album/\(album[index[0].row].id!)/list", parameters: nil) { (response: HTTPResponse) -> Void in
                if let err = response.error {
                    println("get photo list error: \(err.localizedDescription)")
                    return
                }
                if let obj: AnyObject = response.responseObject {
                    println("已获取照片列表地址")
                    dispatch_async(dispatch_get_main_queue(),{
                        let resp = AlbumList(JSONDecoder(obj))
                        destinationViewController.data = resp.data!
                        destinationViewController.navigationItem.title = album[index[0].row].name!
                        destinationViewController.count = resp.data!.count
                        destinationViewController.PhotoList.reloadData()
//                        println(resp.data![0].imgUri)
                    })
                }
            }
            println("Request Sended")
        }
    }

}
