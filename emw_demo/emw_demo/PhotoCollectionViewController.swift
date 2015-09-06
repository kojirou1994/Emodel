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
import MWPhotoBrowser
let reuseIdentifier = "PhotoCell"


class PhotoCollectionViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIActionSheetDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var PhotoList: UICollectionView!
    
    var data:[AlbumListData]?
    var count: Int! = 0
    var albumID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("thumb")
        var addBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addPhotoBtnPressed:")
        self.navigationItem.rightBarButtonItem = addBtn
        // Register cell classes
    }
    
    func addPhotoBtnPressed(barButton: UIBarButtonItem) {
        println("add pressed")
        
        var sheet: UIActionSheet = UIActionSheet()
        let title: String = "选择照片"
        sheet.title  = title
        sheet.delegate = self
        sheet.addButtonWithTitle("取消")
        sheet.addButtonWithTitle("从相册选择")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            sheet.addButtonWithTitle("拍照")
        }
        sheet.cancelButtonIndex = 0
        sheet.showInView(self.view)
        sheet.tag = 255
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        
    }

    //MARK: － UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println("count: \(count)")
        return count
    }

    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoThumbCollectionViewCell
        cell.PhotoThumbImage.kf_setImageWithURL(NSURL(string: data![indexPath.row].thumbUri!)!)
        cell.PhotoThumbImage.clipsToBounds = true
        println(indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let picDimension :CGFloat = self.view.frame.width / 4.0
        return CGSizeMake(picDimension, picDimension)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var photos = [MWPhoto]()
        for i in data! {
            photos.append(MWPhoto(URL: NSURL(string: i.imgUri!)!))
        }
        var browse = PhotoBrowserViewController(photos: photos as [AnyObject]!)
        self.navigationController?.pushViewController(browse, animated: true)
        println("选择了照片: \(indexPath)")
    }
    
    //MARK: - UIActionSheetDelegate
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet.tag == 255 {
            let imagePicker:UIImagePickerController = UIImagePickerController();
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                switch (buttonIndex) {
                case 0:
                    return
                case 1:
                    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                case 2:
                    imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                    imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Front
                default:
                    break;
                }
            }
            else {
                if (buttonIndex == 0) {
                    return
                }
                else {
                    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                }
            }
            println("button Index: \(buttonIndex)")
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - UIImagePickerControllerDelegate
    var imageData: NSData?
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageData = UIImageJPEGRepresentation(pickedImage, 0.5)
        }
        dismissViewControllerAnimated(true, completion: nil)
        uploadPhoto()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - Func
    func uploadPhoto() {
        let notice = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        notice.labelText = "上传中"
        println("地址")
        println(serverAddress + "/photo")
        let boundary = Web.multipartBoundary()
        let request = Web.multipartRequest("POST", NSURL(string: serverAddress + "/photo")!, boundary)
        request.setValue(token, forHTTPHeaderField: "Token")
        let fields = ["userId": userId as String, "albumId": albumID as String]
        let data = Web.multipartData(boundary, fields, imageData!)
        let dataTask = NSURLSession.sharedSession().uploadTaskWithRequest(request, fromData: data) { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if (error != nil) {
                println(error)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    notice.labelText = "上传失败，请重试！"
                    notice.hide(true, afterDelay: 1)
                })
            }
            else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    notice.labelText = "上传成功"
                    notice.hide(true, afterDelay: 0.5)
                })
            }
            println(response)
        }
        dataTask.resume()
        println("uploading avatar")
    }

    
}
