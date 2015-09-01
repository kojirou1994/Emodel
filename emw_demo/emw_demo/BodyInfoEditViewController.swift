//
//  BodyInfoEditViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/28.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import XLForm

class BodyInfoEditViewController : XLFormViewController {
    
    private enum Tags : String {
        case BloodType = "bloodType"
        case Height = "height"
        case Weight = "weight"
        case Bust = "bust"
        case Waist = "waistline"
        case Hip = "hips"
        case CupSize = "cup"
        case Introduction = "introduction"
        case Service = "service"
        case ClothesSize = "clothesSize"
        case ShoesSize = "shoeSize"
        case TrouserSize = "trousers"
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
        
        form = XLFormDescriptor(title: "资料编辑")
        form.assignFirstResponderOnShow = false
        
        section = XLFormSectionDescriptor.formSectionWithTitle("基本信息")
        section.footerTitle = "footer"
        form.addFormSection(section)
        
        // 身高
        row = XLFormRowDescriptor(tag: Tags.Height.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "身高(CM)")
        row.value = localUser?.bodyInfo?.height
        section.addFormRow(row)
        
        // 体重
        row = XLFormRowDescriptor(tag: Tags.Weight.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "体重")
        row.value = localUser?.bodyInfo?.weight
        section.addFormRow(row)
        
        // 罩杯
        row = XLFormRowDescriptor(tag: Tags.CupSize.rawValue, rowType: XLFormRowDescriptorTypeText, title: "罩杯")
        row.value = localUser?.bodyInfo?.cupSize
        section.addFormRow(row)
        
        // 胸围
        row = XLFormRowDescriptor(tag: Tags.Bust.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "胸围")
        row.value = localUser?.bodyInfo?.bust!
        section.addFormRow(row)
        
        // 腰围
        row = XLFormRowDescriptor(tag: Tags.Waist.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "腰围")
        row.value = localUser?.bodyInfo?.waist!
        section.addFormRow(row)
        
        // 臀围
        row = XLFormRowDescriptor(tag: Tags.Hip.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "臀围")
        row.value = localUser?.bodyInfo?.hip!
        section.addFormRow(row)
        
        // 衣服尺寸
        row = XLFormRowDescriptor(tag: Tags.ClothesSize.rawValue, rowType: XLFormRowDescriptorTypeText, title: "衣服尺寸")
        row.value = localUser?.bodyInfo?.clothesSize
        section.addFormRow(row)
        
        // 裤子尺寸
        row = XLFormRowDescriptor(tag: Tags.TrouserSize.rawValue, rowType: XLFormRowDescriptorTypeText, title: "裤子尺寸")
        row.value = localUser?.bodyInfo?.trousersSize
        section.addFormRow(row)
        
        // 鞋子尺寸
        row = XLFormRowDescriptor(tag: Tags.ShoesSize.rawValue, rowType: XLFormRowDescriptorTypeText, title: "鞋子尺寸")
        row.value = localUser?.bodyInfo?.shoesSize
        section.addFormRow(row)
        
        
        // 个人简介
        section = XLFormSectionDescriptor.formSectionWithTitle("个人简介")
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: Tags.Introduction.rawValue, rowType: XLFormRowDescriptorTypeTextView)
        row.cellConfigAtConfigure["textView.placeholder"] = "Introduction"
        row.value = localUser?.bodyInfo?.introduction!
        
        section.addFormRow(row)
        
        self.form = form
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "savePressed:")
        println(self.httpParameters())
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
}
