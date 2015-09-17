//
//  PriceInfoEditViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/28.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import XLForm
import Alamofire

class BusinessInfoEditViewController: XLFormViewController {
    private enum Tags : String {
        case InPrice = "inPrice"
        case OutPrice = "outPrice"
        case UnderWearPrice = "underwearPrice"
        case DayPrice = "dayPrice"
        case StartCount = "startCount"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initializeForm()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeForm()
    }
    // MARK: Helpers
    
    func initializeForm() {
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "身价")
        form.assignFirstResponderOnShow = false
        
        section = XLFormSectionDescriptor.formSectionWithTitle("身价")
        section.footerTitle = "footer"
        form.addFormSection(section)
        
        // 内景价位
        row = XLFormRowDescriptor(tag: Tags.InPrice.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "内景价位")
        row.value = localUser.businessInfo?.inPrice
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 外景价格
        row = XLFormRowDescriptor(tag: Tags.OutPrice.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "外景价位")
        row.value = localUser.businessInfo?.outPrice
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 内衣价格
        row = XLFormRowDescriptor(tag: Tags.UnderWearPrice.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "内衣价位")
        row.value = localUser.businessInfo?.underwearPrice
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 包日价格
        row = XLFormRowDescriptor(tag: Tags.DayPrice.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "包日价格")
        row.value = localUser.businessInfo?.dayPrice
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 起拍件数
        row = XLFormRowDescriptor(tag: Tags.StartCount.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "起拍件数")
        row.value = localUser.businessInfo?.startCount
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        

        self.form = form
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "savePressed:")
        print(self.httpParameters())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func savePressed(button: UIBarButtonItem) {
        var inPrice,outPrice,underwearPrice,dayPrice,startCount: Int
        if let temp = (form.formRowWithTag(Tags.InPrice.rawValue)!.value as? Int) {
            inPrice = temp
        }
        else {
            inPrice = 0
        }
        if let temp = (form.formRowWithTag(Tags.OutPrice.rawValue)!.value as? Int) {
            outPrice = temp
        }
        else {
            outPrice = 0
        }
        if let temp = (form.formRowWithTag(Tags.UnderWearPrice.rawValue)!.value as? Int) {
            underwearPrice = temp
        }
        else {
            underwearPrice = 0
        }
        if let temp = (form.formRowWithTag(Tags.DayPrice.rawValue)!.value as? Int) {
            dayPrice = temp
        }
        else {
            dayPrice = 0
        }
        if let temp = (form.formRowWithTag(Tags.StartCount.rawValue)!.value as? Int) {
            startCount = temp
        }
        else {
            startCount = 0
        }
        
        let para = [
            "inPrice": inPrice,
            "outPrice": outPrice,
            "underwearPrice": underwearPrice,
            "dayPrice": dayPrice,
            "startCount": startCount,
        ]
        print(para)
        
        var manager = Manager.sharedInstance
        // Add Headers
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Token":token!,
        ]
        let encoding = Alamofire.ParameterEncoding.URL
        
        // Fetch Request
        Alamofire.request(.PUT, serverAddress + "/user/" + userId + "/businessinfo", parameters: para, encoding: encoding)
            .responseJSON { _, _, JSON, error in
                if (error == nil) {
                    print("HTTP Response Body: \(JSON)")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let alertView = UIAlertView(title: "更新成功", message: "okokokok", delegate: self, cancelButtonTitle: "OK")
                        alertView.show()
                    })
                }
                else {
                    print("HTTP HTTP Request failed: \(error)")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let alertView = UIAlertView(title: "失败", message: "byebye", delegate: self, cancelButtonTitle: "OK")
                        alertView.show()
                    })
                }
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
