//
//  PriceInfoEditViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/28.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import XLForm

class PriceInfoEditViewController: XLFormViewController {
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
    
    required init(coder aDecoder: NSCoder) {
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
        row = XLFormRowDescriptor(tag: Tags.InPrice.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "内景价位(元)")
        row.value = localUser?.businessInfo?.inPrice!
        section.addFormRow(row)
        
        // 外景价格
        row = XLFormRowDescriptor(tag: Tags.OutPrice.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "外景价位")
        row.value = localUser?.businessInfo?.outPrice!
        section.addFormRow(row)
        
        // 内衣价格
        row = XLFormRowDescriptor(tag: Tags.UnderWearPrice.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "内衣价位")
        row.value = localUser?.businessInfo?.underwearPrice!
        section.addFormRow(row)
        
        // 包日价格
        row = XLFormRowDescriptor(tag: Tags.DayPrice.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "包日价格")
        row.value = localUser?.businessInfo?.dayPrice!
        section.addFormRow(row)
        
        // 起拍件数
        row = XLFormRowDescriptor(tag: Tags.StartCount.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "起拍件数")
        row.value = localUser?.businessInfo?.startCount!
        section.addFormRow(row)
        

        self.form = form
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "savePressed:")
        println(self.httpParameters())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func savePressed(button: UIBarButtonItem) {
        //提交更新PUT
        let validationErrors : Array<NSError> = self.formValidationErrors() as! Array<NSError>
        if (validationErrors.count > 0) {
            self.showFormValidationError(validationErrors.first)
            return
        }
        self.tableView.endEditing(true)
        println(self.httpParameters())
        let alertView = UIAlertView(title: "Valid Form", message: "No errors found", delegate: self, cancelButtonTitle: "OK")
        alertView.show()
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
