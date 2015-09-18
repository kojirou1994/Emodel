//
//  PhotoCollectionViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/13.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import Kingfisher
import MWPhotoBrowser
import Alamofire

let reuseIdentifier = "PhotoCell"

class PhotoCollectionViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIActionSheetDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var PhotoList: UICollectionView!
    
    @IBAction func uploadPhotoBtnPressed(sender: AnyObject) {
        let sheet: UIActionSheet = UIActionSheet()
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
    var data:[AlbumListData]?
    ///本相册的id，以获取数据
    var albumID: String!
    var deleteMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("thumb")
        let addBtn = UIBarButtonItem(title: "编辑", style: UIBarButtonItemStyle.Plain, target: self, action: "changeEditMode:")
//        (barButtonSystemItem: UIBarButtonItemSt, target: self, action: "addPhotoBtnPressed:")
        self.navigationItem.rightBarButtonItem = addBtn
        updatePhotoCollection()
        // Register cell classes
    }
    
    func updatePhotoCollection() {
        Alamofire.request(.GET, serverAddress + "/album/\(albumID)/list")
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    print("Validation Successful")
                    let resp = AlbumList(JSONDecoder(result.value!))
                    self.data = resp.data
                    self.PhotoList.reloadData()
                case .Failure(_, let error):
                    print(error)
                }
        }
    }
    
    func changeEditMode(barButton: UIBarButtonItem) {
        if (deleteMode) {
            barButton.title = "编辑"
            deleteMode = false
            for cell in PhotoList.visibleCells() as! [PhotoThumbCollectionViewCell] {
                cell.deleteButton.hidden = true
            }
        }
        else {
            barButton.title = "完成"
            deleteMode = true
            for cell in PhotoList.visibleCells() as! [PhotoThumbCollectionViewCell] {
                cell.deleteButton.hidden = false
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        
    }

    //MARK: － UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data == nil ? 0 : data!.count
    }

    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoThumbCollectionViewCell
        cell.PhotoThumbImage.kf_setImageWithURL(NSURL(string: data![indexPath.row].thumbUri!)!)
        cell.PhotoThumbImage.clipsToBounds = true
        if (deleteMode) {
            cell.deleteButton.hidden = false
        }
        print(indexPath)
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
        if (deleteMode) {
            print("开始删除 \(indexPath)")
            deletePhoto(indexPath.row)
        }
        else {
            var photoSource = [MWPhoto]()
            for i in data! {
                photoSource.append(MWPhoto(URL: NSURL(string: i.imgUri!)!))
            }
            let te = PhotoBrowserViewController()
            te.photodata = self.data!
            //        te.reloadData()
            //        te.setCurrentPhotoIndex(UInt(indexPath.row))
            let browse = MWPhotoBrowser(photos: photoSource)
            print(UInt(indexPath.row))
//            PhotoBrowserViewController(photos: photoSource as [AnyObject]!)
            browse.setCurrentPhotoIndex(UInt(indexPath.row))
            self.navigationController?.pushViewController(browse, animated: true)
            print("选择了照片: \(indexPath)")
        }
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
            print("button Index: \(buttonIndex)")
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - UIImagePickerControllerDelegate
    var imageData: NSData?
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
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
        print("地址")
        print(serverAddress + "/photo")
        let boundary = Web.multipartBoundary()
        let request = Web.multipartRequest("POST", NSURL(string: serverAddress + "/photo")!, boundary)
        request.setValue(token, forHTTPHeaderField: "Token")
        let fields = ["userId": userId as String, "albumId": albumID as String]
        let data = Web.multipartData(boundary, fields, imageData!)
        let dataTask = NSURLSession.sharedSession().uploadTaskWithRequest(request, fromData: data) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil) {
                print(error)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    notice.labelText = "上传失败，请重试！"
                    notice.hide(true, afterDelay: 1)
                })
            }
            else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    notice.labelText = "上传成功"
                    notice.hide(true, afterDelay: 0.5)
                    self.updatePhotoCollection()
                })
            }
            print(response)
        }
        dataTask.resume()
        print("uploading photo")
    }
    
    
    func deletePhoto(index: Int) {

        let notice = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        notice.labelText = "删除中"

        var str = data![index].id

        Alamofire.request(.DELETE, serverAddress + "/photo/\(str!)", parameters: nil, encoding: ParameterEncoding.URL, headers: ["Token": token])
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    debugPrint(result)
                    self.data!.removeAtIndex(index)
                    dispatch_async(dispatch_get_main_queue(),{
                        notice.labelText = "删除成功"
                        notice.hide(true, afterDelay: 0.3)
                        self.PhotoList.reloadData()
                    })
                case .Failure(_, let error):
                    print(error)
                    dispatch_async(dispatch_get_main_queue(),{
                        notice.labelText = "删除失败"
                        notice.hide(true, afterDelay: 0.3)
                    })
                }
        }
    }
}
