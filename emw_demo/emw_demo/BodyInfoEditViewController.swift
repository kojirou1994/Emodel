//
//  BodyInfoEditViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/28.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import XLForm
import Alamofire

class BodyInfoEditViewController : XLFormViewController {
    
    private enum BodyInfoTag: String {
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
        row = XLFormRowDescriptor(tag: BodyInfoTag.Height.rawValue, rowType: XLFormRowDescriptorTypeText, title: "身高(CM)")
        row.value = localUser.bodyInfo?.height
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 体重
        row = XLFormRowDescriptor(tag: BodyInfoTag.Weight.rawValue, rowType: XLFormRowDescriptorTypeText, title: "体重")
        row.value = localUser.bodyInfo?.weight
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 罩杯
        row = XLFormRowDescriptor(tag: BodyInfoTag.CupSize.rawValue, rowType: XLFormRowDescriptorTypeText, title: "罩杯")
        row.value = localUser.bodyInfo?.cupSize
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 胸围
        row = XLFormRowDescriptor(tag: BodyInfoTag.Bust.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "胸围")
        row.value = localUser.bodyInfo?.bust!
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 腰围
        row = XLFormRowDescriptor(tag: BodyInfoTag.Waist.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "腰围")
        row.value = localUser.bodyInfo?.waist!
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 臀围
        row = XLFormRowDescriptor(tag: BodyInfoTag.Hip.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "臀围")
        row.value = localUser.bodyInfo?.hip!
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 衣服尺寸
        row = XLFormRowDescriptor(tag: BodyInfoTag.ClothesSize.rawValue, rowType: XLFormRowDescriptorTypeText, title: "衣服尺寸")
        row.value = localUser.bodyInfo?.clothesSize
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 裤子尺寸
        row = XLFormRowDescriptor(tag: BodyInfoTag.TrouserSize.rawValue, rowType: XLFormRowDescriptorTypeText, title: "裤子尺寸")
        row.value = localUser.bodyInfo?.trousersSize
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 鞋子尺寸
        row = XLFormRowDescriptor(tag: BodyInfoTag.ShoesSize.rawValue, rowType: XLFormRowDescriptorTypeText, title: "鞋子尺寸")
        row.value = localUser.bodyInfo?.shoesSize
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        
        // 个人简介
        section = XLFormSectionDescriptor.formSectionWithTitle("个人简介")
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: BodyInfoTag.Introduction.rawValue, rowType: XLFormRowDescriptorTypeTextView)
        row.cellConfigAtConfigure["textView.placeholder"] = "Introduction"
        row.value = localUser.bodyInfo?.introduction!
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textView.textColor")
        
        section.addFormRow(row)
        
        self.form = form
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "savePressed:")
        println(localUser.bodyInfo?.height)
    }
    
    func savePressed(button: UIBarButtonItem) {
        //提交更新PUT
        var bloodType,height,weight,cup,introduction,service,clothesSize,shoeSize,trousers: String
        var bust, hips, waistline: Int
        //血型
//        if let temp = (form.formRowWithTag(BodyInfoTag.BloodType.rawValue)!.value as? String) {
//            bloodType = temp
//        }
//        else {
//            bloodType = ""
//        }
        if let temp = (form.formRowWithTag(BodyInfoTag.Height.rawValue)!.value as? String) {
            height = temp
        }
        else {
            height = ""
        }
        if let temp = (form.formRowWithTag(BodyInfoTag.Weight.rawValue)!.value as? String) {
            weight = temp
        }
        else {
            weight = ""
        }
        if let temp = (form.formRowWithTag(BodyInfoTag.Bust.rawValue)!.value as? Int) {
            bust = temp
        }
        else {
            bust = 0
        }
        if let temp = (form.formRowWithTag(BodyInfoTag.Waist.rawValue)!.value as? Int) {
            waistline = temp
        }
        else {
            waistline = 0
        }
        if let temp = (form.formRowWithTag(BodyInfoTag.Hip.rawValue)!.value as? Int) {
            hips = temp
        }
        else {
            hips = 0
        }
        if let temp = (form.formRowWithTag(BodyInfoTag.CupSize.rawValue)!.value as? String) {
            cup = temp
        }
        else {
            cup = ""
        }
        if let temp = (form.formRowWithTag(BodyInfoTag.Introduction.rawValue)!.value as? String) {
            introduction = temp
        }
        else {
            introduction = ""
        }

//        if let temp = (form.formRowWithTag(BodyInfoTag.Service.rawValue)!.value as? String) {
//            service = temp
//        }
//        else {
//            service = ""
//        }
        if let temp = (form.formRowWithTag(BodyInfoTag.ClothesSize.rawValue)!.value as? String) {
            clothesSize = temp
        }
        else {
            clothesSize = ""
        }
        if let temp = (form.formRowWithTag(BodyInfoTag.ShoesSize.rawValue)!.value as? String) {
            shoeSize = temp
        }
        else {
            shoeSize = ""
        }
        if let temp = (form.formRowWithTag(BodyInfoTag.TrouserSize.rawValue)!.value as? String) {
            trousers = temp
        }
        else {
            trousers = ""
        }
        
        
        let para = [
//            "bloodType": bloodType,
            "bust": bust,
            "clothesSize": clothesSize,
            "cup": cup,
            "height": height,
            "hips": hips,
            "introduction": introduction,
//            "service": service,
            "shoeSize": shoeSize,
            "trousers": trousers,
            "waistline": waistline,
            "weight": weight
        ]
        println(para)
        
        var manager = Manager.sharedInstance
        // Add Headers
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Token":token!,
        ]
        let encoding = Alamofire.ParameterEncoding.URL
        
        // Fetch Request
        Alamofire.request(.PUT, serverAddress + "/user/" + userId + "/bodyinfo", parameters: (para as! [String : AnyObject]), encoding: encoding)
            .responseJSON { _, _, JSON, error in
                if (error == nil) {
                    println("HTTP Response Body: \(JSON)")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let alertView = UIAlertView(title: "更新成功", message: "okokokok", delegate: self, cancelButtonTitle: "OK")
                        alertView.show()
                    })
                }
                else {
                    println("HTTP HTTP Request failed: \(error)")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let alertView = UIAlertView(title: "失败", message: "byebye", delegate: self, cancelButtonTitle: "OK")
                        alertView.show()
                    })
                }
        }
    }
}
