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
        let addAlert = UIAlertView(title: "添加相册", message: "请输入相册标题", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
        addAlert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        addAlert.tag = 1
        addAlert.show()
    }
    
    func newAlbum(title: String) {
        var request = HTTPTask()
        request.requestSerializer = HTTPRequestSerializer()
        request.requestSerializer.headers["Token"] = token!
        let params: Dictionary<String,AnyObject> = ["name": title, "userId": userId]
        request.POST(serverAddress + "/album", parameters: params, completionHandler: {(response: HTTPResponse) in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertView(title: "添加失败", message: "请重新添加", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                })
                return
            }
            if let obj: AnyObject = response.responseObject {
                print("相册添加成功")
                self.updateUserInfo()
            }
        })

    }
    
    func updateUserInfo() {
        var request = HTTPTask()
        request.GET(serverAddress + "/user/\(userId!)", parameters: nil) { (response: HTTPResponse) -> Void in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                let resp = User(JSONDecoder(obj))
                switch (resp.status!) {
                case 200:
                    print("update UserInfo success")
                    localUser = resp.data
                    print(localUser!.star)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.updateInterface()
                    })
                default:
                    print("get user info failed")
                }
            }
        }
        
    }
    
    func updateInterface() {
        album = localUser.albumInfo!
        self.AlbumListCollectionView.reloadData()
    }
    //MARK: - UICllectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (album == nil) {
            return 0
        }
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
            let destinationViewController: PhotoCollectionViewController = segue.destinationViewController as! PhotoCollectionViewController
            var request = HTTPTask()
            request.GET(serverAddress + "/album/\(album[index[0].row].id!)/list", parameters: nil) { (response: HTTPResponse) -> Void in
                if let err = response.error {
                    print("get photo list error: \(err.localizedDescription)")
                    return
                }
                if let obj: AnyObject = response.responseObject {
                    print("已获取照片列表地址")
                    dispatch_async(dispatch_get_main_queue(),{
                        let resp = AlbumList(JSONDecoder(obj))
                        destinationViewController.data = resp.data!
                        destinationViewController.navigationItem.title = self.album[index[0].row].name!
                        destinationViewController.count = resp.data!.count
                        destinationViewController.albumID = self.album[index[0].row].id!
                        destinationViewController.PhotoList.reloadData()
//                        println(resp.data![0].imgUri)
                    })
                }
            }
            print("Request Sended")
        }
    }

}
