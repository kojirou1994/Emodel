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

var AlbumData: Array<AlbumList> = Array<AlbumList>()
var selectedAlbum: AlbumList = AlbumList()

var selectedAlbumIndex:Int = 0
var photos: NSMutableArray = []
//var thumbs: NSMutableArray = []
class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIAlertViewDelegate {
    @IBAction func EditBtnPressed(sender: AnyObject) {
        print("show删除相册界面")
    }
    
    @IBOutlet weak var AlbumListCollectionView: UICollectionView!
    
    var album :Array<Album>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addAlbum:")
        self.navigationItem.rightBarButtonItem = addBtn
        album = localUser.albumInfo!
        self.AlbumListCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Func
    
    func addAlbum(barButton: UIBarButtonItem) {
        print("add pressed")
        let inputAlbumName = UIAlertController(title: "添加相册", message: "请输入相册标题", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let addAlert = UIAlertView(title: "添加相册", message: "请输入相册标题", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
        addAlert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        addAlert.tag = 1
        addAlert.show()
    }
    
    func newAlbum(title: String) {
        
        Alamofire.request(.POST, serverAddress + "/album", parameters: ["name": title, "userId": userId], encoding: .JSON, headers: ["Token": token])
        .validate()
        .responseJSON { (_, _, result) -> Void in
            switch result {
            case .Success:
                print("相册添加成功")
                self.updateAlbumInfo()
            case .Failure(_, let error):
                print(error)
                dispatch_async(dispatch_get_main_queue(), {
                    self.showSimpleAlert("", message: "")
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
        album = localUser.albumInfo!
        self.AlbumListCollectionView.reloadData()
    }
    //MARK: - UICllectionViewDataSource
     
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album == nil ? 0 : album.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = AlbumListCollectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AlbumThumbCollectionViewCell
        cell.AlbumTitle.text = album[indexPath.row].name!
        cell.ThumbImage.contentMode = UIViewContentMode.ScaleAspectFill
        cell.ThumbImage.clipsToBounds = true
        cell.ThumbImage.kf_setImageWithURL(NSURL(string: album[indexPath.row].imgUri!)!)
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
    
    //MARK: - AlertViewDelegate
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex)
        if (alertView.tag == 1 && buttonIndex == 1) {
            
            let newAlbumName = alertView.textFieldAtIndex(0)?.text
            
            if  newAlbumName == ""{
                let alert = UIAlertView(title: "输入错误", message: "标题不可为空！", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                print("alert show")
            }
            else {
                print("New Album Name: \(newAlbumName)")
                newAlbum(newAlbumName!)
            }
        }
    }
    
    //MARK: - Navigation
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "GoToAlbumDetail" {
            print("ShouldPerformSegue")
//            sleep(2)
            return true
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToAlbumDetail" {
            print("prepareForSegue")
            let index = self.AlbumListCollectionView.indexPathsForSelectedItems()
            print("点击了相册 序号：")
            print(index)
            let pcvc: PhotoCollectionViewController = segue.destinationViewController as! PhotoCollectionViewController
            pcvc.albumID = self.album[index![0].row].id!
            pcvc.navigationItem.title = self.album[index![0].row].name
            print("Request Sended")
        }
    }

}
