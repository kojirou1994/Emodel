//
//  UserData.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/6.
//  Copyright (c) 2015年 emodel. All rights reserved.
//
import XLForm
import SwiftHTTP
import MBProgressHUD

class BaseInfoEditViewController : XLFormViewController {
    
    private enum BaseInfoTag : String {
        case QQ = "QQ"
        case Age = "age"
        case Birthday = "birthday"
        case Email = "email"
        case Introduction = "introduction"
        case Mobile = "mobile"
        case NickName = "nickName"
        case RealName = "realName"
        case Service = "service"
        case Sex = "sex"
        case Wechat = "wechat"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initializeForm()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeForm()
    }

    func initializeForm() {
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "资料编辑")
        form.assignFirstResponderOnShow = false
        
        section = XLFormSectionDescriptor.formSectionWithTitle("修改完成后请点击提交")
        section.footerTitle = "footer"
        form.addFormSection(section)
        
        // QQ
        row = XLFormRowDescriptor(tag: BaseInfoTag.QQ.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "QQ")
        row.value = localUser.baseInfo?.QQ
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        section.addFormRow(row)
        
        // 年龄
        row = XLFormRowDescriptor(tag: BaseInfoTag.Age.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "年龄")
        row.value = localUser.baseInfo?.age
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        section.addFormRow(row)
        
        // 转换生日string to nsdate
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        // 生日
        row = XLFormRowDescriptor(tag: BaseInfoTag.Birthday.rawValue, rowType: XLFormRowDescriptorTypeDateInline, title: "生日")
        row.value = format.dateFromString(localUser.baseInfo!.birthday!)
        println("生日 \(localUser.baseInfo?.birthday)")
        section.addFormRow(row)
        
        // 邮箱
        row = XLFormRowDescriptor(tag: BaseInfoTag.Email.rawValue, rowType: XLFormRowDescriptorTypeEmail, title: "邮箱")
        row.value = localUser.baseInfo?.email
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        section.addFormRow(row)
        
        // 个人简介
        row = XLFormRowDescriptor(tag: BaseInfoTag.Introduction.rawValue, rowType: XLFormRowDescriptorTypeTextView, title: "个人简介")
        row.value = localUser.baseInfo?.introduction
        section.addFormRow(row)
        
        // 手机号
        row = XLFormRowDescriptor(tag: BaseInfoTag.Mobile.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "手机号")
        row.value = localUser.baseInfo?.mobile!
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        section.addFormRow(row)
        
        // 用户名
        row = XLFormRowDescriptor(tag: BaseInfoTag.NickName.rawValue, rowType: XLFormRowDescriptorTypeText, title: "用户名")
        row.value = localUser.baseInfo?.nickName
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        section.addFormRow(row)
        
        // 真实姓名
        row = XLFormRowDescriptor(tag: BaseInfoTag.RealName.rawValue, rowType: XLFormRowDescriptorTypeText, title: "真实姓名")
        row.value = localUser.baseInfo?.realName
        section.addFormRow(row)
        
        // 个人服务
        row = XLFormRowDescriptor(tag: BaseInfoTag.Service.rawValue, rowType: XLFormRowDescriptorTypeText, title: "个人服务")
        row.value = localUser.baseInfo?.service
        section.addFormRow(row)
        
        
        // 性别
        row = XLFormRowDescriptor(tag: BaseInfoTag.Sex.rawValue, rowType: XLFormRowDescriptorTypeText, title: "性别")
        row.value = localUser.baseInfo?.sex
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        section.addFormRow(row)
        
        // 微信账号
        row = XLFormRowDescriptor(tag: BaseInfoTag.Wechat.rawValue, rowType: XLFormRowDescriptorTypeText, title: "微信账号")
        row.value = localUser.baseInfo?.wechat
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
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
        var re = NSMutableURLRequest(URL: NSURL(string: serverAddress + "/user/" + userId + "/baseinfo")!)
        re.setValue(token, forHTTPHeaderField: "Token")
        re.HTTPMethod = "PUT"
        
        let params: Dictionary = self.formValues()
        println("params:")
        println(params)
        var format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        var results = [String: String?]()
        results[BaseInfoTag.QQ.rawValue] = form.formRowWithTag(BaseInfoTag.QQ.rawValue)!.value as? String
        
        if let value = form.formRowWithTag(BaseInfoTag.Age.rawValue)!.value as? Int {
            results[BaseInfoTag.Age.rawValue] = String(value)
        }
        
        if let value = form.formRowWithTag(BaseInfoTag.Birthday.rawValue)!.value as? NSDate {
            results[BaseInfoTag.Birthday.rawValue] = format.stringFromDate(value)
        }
        if let value = form.formRowWithTag(BaseInfoTag.Email.rawValue)!.value as? String {
            results[BaseInfoTag.Email.rawValue] = value
        }
        if let value = form.formRowWithTag(BaseInfoTag.Introduction.rawValue)!.value as? String {
            results[BaseInfoTag.Introduction.rawValue] = value
        }
        if let value = form.formRowWithTag(BaseInfoTag.Mobile.rawValue)!.value as? String {
            results[BaseInfoTag.Mobile.rawValue] = value
        }
        if let value = form.formRowWithTag(BaseInfoTag.NickName.rawValue)!.value as? String {
            results[BaseInfoTag.NickName.rawValue] = value
        }
        if let value = form.formRowWithTag(BaseInfoTag.RealName.rawValue)!.value as? String {
            results[BaseInfoTag.RealName.rawValue] = value
        }
        if let value = form.formRowWithTag(BaseInfoTag.Service.rawValue)!.value as? String {
            results[BaseInfoTag.Service.rawValue] = value
        }
        if let value = form.formRowWithTag(BaseInfoTag.Sex.rawValue)!.value as? String {
            results[BaseInfoTag.Sex.rawValue] = value
        }
        if let value = form.formRowWithTag(BaseInfoTag.Wechat.rawValue)!.value as? String {
            results[BaseInfoTag.Wechat.rawValue] = value
        }
        println("result: \(results)")
        
//        println("birthday: \(pa)")
//        var jsondata = NSJSONSerialization.dataWithJSONObject(results, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        var bodyData = ""
        for (key,value) in results {
            if (value == nil) {
                continue
            }
            let scapedKey = key.stringByAddingPercentEncodingWithAllowedCharacters(
                .URLHostAllowedCharacterSet())!
            let scapedValue = value!.stringByAddingPercentEncodingWithAllowedCharacters(
                .URLHostAllowedCharacterSet())!
            bodyData += "\(scapedKey)=\(scapedValue)&"
        }
        re.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
//            bodyString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        var task = NSURLSession.sharedSession().dataTaskWithRequest(re, completionHandler: { (data, response, error) -> Void in
            if (error == nil) {
                println("更新成功")
                println(response)
            }
            else {
                println("更新失败")
            }
        })
        task.resume()
        let alertView = UIAlertView(title: "更新成功", message: "okokokok", delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
}

func stringFromQueryParameters(queryParameters : Dictionary<String, String>) -> String {
    var parts: [String] = []
    for (name, value) in queryParameters {
        var part = NSString(format: "%@=%@",
            name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!,
            value.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        parts.append(part as String)
    }
    return "&".join(parts)
}
