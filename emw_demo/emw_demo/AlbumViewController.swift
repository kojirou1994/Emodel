//
//  AlbumViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/13.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Kingfisher
import MWPhotoBrowser
import MBProgressHUD
import Alamofire

class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    @IBAction func EditBtnPressed(sender: AnyObject) {
        print("show删除相册界面")
    }
    
    @IBOutlet weak var AlbumListCollectionView: UICollectionView!
    
    var albumData :[Album]?
    var editEnabled: Bool = false
    var targetUserId: String! = userId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (targetUserId == userId) {
            editEnabled = true
            let addBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addAlbum:")
            self.navigationItem.rightBarButtonItem = addBtn
            albumData = localUser.albumInfo
        }
        else {
            Alamofire.request(.GET, serverAddress + "/user/\(targetUserId)")
                .validate()
                .responseJSON { _, _, result in
                    switch result {
                    case .Success:
                        let resp = User(JSONDecoder(result.value!))
                        self.albumData = resp.data?.albumInfo
                        dispatch_async(dispatch_get_main_queue(), {
                            self.AlbumListCollectionView.reloadData()
                        })
                    case .Failure(_, let error):
                        print(error)
                    }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - editEnabled Func
    
    func addAlbum(barButton: UIBarButtonItem) {
        print("add pressed")
        let inputAlbumName = UIAlertController(title: "添加相册", message: "请输入相册标题", preferredStyle: UIAlertControllerStyle.Alert)
        
        inputAlbumName.addTextFieldWithConfigurationHandler { (albumNameTextField: UITextField) -> Void in
            albumNameTextField.placeholder = "在此输入"
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action: UIAlertAction) -> Void in
            print("cancle tapped")
        }
        let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            print("ok tapped")
            if let albumNameTF = inputAlbumName.textFields?.first {
                guard let title = albumNameTF.text else {
                    return
                }
                self.newAlbum(title)
            }
            else {
                print("????没读到")
            }
        }
        inputAlbumName.addAction(cancelAction)
        inputAlbumName.addAction(okAction)
        self.presentViewController(inputAlbumName, animated: true, completion: nil)
        
    }
    
    func newAlbum(title: String) {
        print("adding new album")
        Alamofire.request(.POST, serverAddress + "/album", parameters: ["name": title, "userId": userId], encoding: .URL, headers: ["Token": token])
        .validate()
        .responseJSON { (_, _, result) -> Void in
            switch result {
            case .Success:
                print("相册添加成功")
                self.updateAlbumInfo()
            case .Failure(_, let error):
                print(error)
                dispatch_async(dispatch_get_main_queue(), {
                    self.showSimpleAlert("相册添加失败", message: "请重试或稍后再试")
                })
            }
        }
    }
    
    func updateAlbumInfo() {
        Alamofire.request(.GET, serverAddress + "/user/\(userId!)")
            .validate()
            .responseJSON { _, _, result in
        switch result {
        case .Success:
            let resp = User(JSONDecoder(result.value!))
            localUser.albumInfo = resp.data?.albumInfo
            dispatch_async(dispatch_get_main_queue(), {
                self.updateInterface()
            })
        case .Failure(_, let error):
            print(error)
        }
        }
    }
    
    func updateInterface() {
        albumData = localUser.albumInfo!
        self.AlbumListCollectionView.reloadData()
    }
    //MARK: - UICllectionViewDataSource
     
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumData == nil ? 0 : albumData!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = AlbumListCollectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AlbumThumbCollectionViewCell
        cell.AlbumTitle.text = albumData?[indexPath.row].name
        cell.ThumbImage.contentMode = UIViewContentMode.ScaleAspectFill
        cell.ThumbImage.clipsToBounds = true
        cell.ThumbImage.kf_setImageWithURL(NSURL(string: albumData![indexPath.row].imgUri!)!)
        return cell
    }
    
    //MARK: - UICllectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("did Select\(indexPath)")
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let picDimension: CGFloat = self.view.frame.width / 32.0 * 13
        print("size: \(picDimension)")
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
    
    
    //MARK: - Navigation
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "GoToAlbumDetail" {
            return true
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToAlbumDetail" {
            let index = self.AlbumListCollectionView.indexPathsForSelectedItems()
            let pcvc: PhotoCollectionViewController = segue.destinationViewController as! PhotoCollectionViewController
            pcvc.albumID = albumData![index![0].row].id!
            pcvc.navigationItem.title = albumData![index![0].row].name
            pcvc.editEnabled = editEnabled
        }
    }

}
