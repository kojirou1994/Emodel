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
import MBProgressHUD

var AlbumData: Array<AlbumList> = Array<AlbumList>()
var selectedAlbum: AlbumList = AlbumList()

var selectedAlbumIndex:Int = 0
var photos: NSMutableArray = []
var thumbs: NSMutableArray = []
class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIAlertViewDelegate {
    @IBAction func EditBtnPressed(sender: AnyObject) {
        println("show删除相册界面")
    }
    
    @IBOutlet weak var AlbumListCollectionView: UICollectionView!
    
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
    
    //MARK: - Func
    
    func addAlbum(barButton: UIBarButtonItem) {
        println("add pressed")
        
        var addAlert = UIAlertView(title: "添加相册", message: "请输入相册标题", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
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
                println("error: \(err.localizedDescription)")
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertView(title: "添加失败", message: "请重新添加", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                })
                return
            }
            if let obj: AnyObject = response.responseObject {
                println("相册添加成功")
            }
        })

    }
    //MARK: - CllectionViewDataSource
    
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
    
    //MARK: - CllectionViewDelegate
    
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
    
    //MARK: - AlertViewDelegate
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        println(buttonIndex)
        if (alertView.tag == 1 && buttonIndex == 1) {
            
            let newAlbumName = alertView.textFieldAtIndex(0)?.text
            
            if  newAlbumName == ""{
                let alert = UIAlertView(title: "输入错误", message: "标题不可为空！", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                println("alert show")
            }
            else {
                println("New Album Name: \(newAlbumName)")
                newAlbum(newAlbumName!)
            }
        }
    }
    /*
    // Called when a button is clicked. The view will be automatically dismissed after this call returns
    optional func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    
    // Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
    // If not defined in the delegate, we simulate a click in the cancel button
    optional func alertViewCancel(alertView: UIAlertView)
    
    optional func willPresentAlertView(alertView: UIAlertView) // before animation and showing view
    optional func didPresentAlertView(alertView: UIAlertView) // after animation
    
    optional func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) // before animation and hiding view
    optional func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) // after animation
    
    // Called after edits in any of the default fields added by the style
    optional func alertViewShouldEnableFirstOtherButton(alertView: UIAlertView) -> Bool
*/
    //MARK: - Navigation
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "GoToAlbumDetail" {
            println("ShouldPerformSegue")
            sleep(2)
            return true
        }
        return true
    }
    
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
                        destinationViewController.albumID = album[index[0].row].id!
                        destinationViewController.PhotoList.reloadData()
//                        println(resp.data![0].imgUri)
                    })
                }
            }
            println("Request Sended")
        }
    }

}
