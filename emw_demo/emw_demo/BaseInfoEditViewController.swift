//
//  UserData.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/6.
//  Copyright (c) 2015年 emodel. All rights reserved.
//
import XLForm
import MBProgressHUD
import Alamofire

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
    
    required init?(coder aDecoder: NSCoder) {
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
        section.footerTitle = ""
        form.addFormSection(section)
        
        // QQ
        row = XLFormRowDescriptor(tag: BaseInfoTag.QQ.rawValue, rowType: XLFormRowDescriptorTypeText, title: "QQ")
        row.value = localUser.baseInfo?.QQ
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
//        row.cellConfigAtConfigure["textField.textColor"] = UIColor.grayColor()
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 年龄
        row = XLFormRowDescriptor(tag: BaseInfoTag.Age.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "年龄")
        row.value = localUser.baseInfo?.age
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
//        section.addFormRow(row)
        
        // 转换生日string to nsdate
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        // 生日
        row = XLFormRowDescriptor(tag: BaseInfoTag.Birthday.rawValue, rowType: XLFormRowDescriptorTypeDateInline, title: "生日")
        row.value = format.dateFromString(localUser.baseInfo!.birthday!)
        print("生日 \(localUser.baseInfo?.birthday)")
        section.addFormRow(row)
        
        // 邮箱
        row = XLFormRowDescriptor(tag: BaseInfoTag.Email.rawValue, rowType: XLFormRowDescriptorTypeEmail, title: "邮箱")
        row.value = localUser.baseInfo?.email
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 个人简介
        row = XLFormRowDescriptor(tag: BaseInfoTag.Introduction.rawValue, rowType: XLFormRowDescriptorTypeTextView, title: "个人简介")
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        row.value = localUser.baseInfo?.introduction
//        section.addFormRow(row)
        
        // 手机号
        row = XLFormRowDescriptor(tag: BaseInfoTag.Mobile.rawValue, rowType: XLFormRowDescriptorTypeInteger, title: "手机号")
        row.value = localUser.baseInfo?.mobile
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 用户名
        row = XLFormRowDescriptor(tag: BaseInfoTag.NickName.rawValue, rowType: XLFormRowDescriptorTypeText, title: "用户名")
        row.value = localUser.baseInfo?.nickName
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 真实姓名
        row = XLFormRowDescriptor(tag: BaseInfoTag.RealName.rawValue, rowType: XLFormRowDescriptorTypeText, title: "真实姓名")
        row.value = localUser.baseInfo?.realName
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 个人服务
        row = XLFormRowDescriptor(tag: BaseInfoTag.Service.rawValue, rowType: XLFormRowDescriptorTypeText, title: "个人服务")
        row.value = localUser.baseInfo?.service
//        section.addFormRow(row)
        
        
        // 性别
        row = XLFormRowDescriptor(tag: BaseInfoTag.Sex.rawValue, rowType: XLFormRowDescriptorTypeText, title: "性别")
        row.value = localUser.baseInfo?.sex
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        // 微信账号
        row = XLFormRowDescriptor(tag: BaseInfoTag.Wechat.rawValue, rowType: XLFormRowDescriptorTypeText, title: "微信账号")
        row.value = localUser.baseInfo?.wechat
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        row.cellConfig.setObject(UIColor.grayColor(), forKey: "textField.textColor")
        section.addFormRow(row)
        
        self.form = form
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "savePressed:")
    }
    
    ///提交更新PUT
    func savePressed(button: UIBarButtonItem) {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let birth = form.formRowWithTag(BaseInfoTag.Birthday.rawValue)!.value as? NSDate
        var sex,nickName,realName,QQ,wechat,email: String
        if let temp = (form.formRowWithTag(BaseInfoTag.Sex.rawValue)!.value as? String) {
            sex = temp
        }
        else {
            sex = ""
        }
        if let temp = (form.formRowWithTag(BaseInfoTag.NickName.rawValue)!.value as? String) {
            nickName = temp
        }
        else {
            nickName = ""
        }
        if let temp = (form.formRowWithTag(BaseInfoTag.RealName.rawValue)!.value as? String) {
            realName = temp
        }
        else {
            realName = ""
        }
        if let temp = (form.formRowWithTag(BaseInfoTag.QQ.rawValue)!.value as? String) {
            QQ = temp
        }
        else {
            QQ = ""
        }
        if let temp = (form.formRowWithTag(BaseInfoTag.Wechat.rawValue)!.value as? String) {
            wechat = temp
        }
        else {
            wechat = ""
        }
        if let temp = (form.formRowWithTag(BaseInfoTag.Email.rawValue)!.value as? String) {
            email = temp
        }
        else {
            email = ""
        }
        let birthday = format.stringFromDate(birth!)

        let para = [
            "sex": sex,
            "nickName": nickName,
            "realName": realName,
            "QQ": QQ,
            "wechat": wechat,
            "email": email,
            "birthday": birthday
        ]
        print(para)
        
        // Fetch Request
        Alamofire.request(.PUT, serverAddress + "/user/" + userId + "/baseinfo", parameters: para, encoding: ParameterEncoding.JSON, headers: ["Token": token])
            .validate()
            .responseJSON { _, _, result in
                switch result {
                case .Success:
                    print("Validation Successful")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showSimpleAlert("更新成功", message: "点击返回")
                    })
                case .Failure(_, let error):
                    print(error)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showSimpleAlert("失败", message: "请重试或稍后再试")
                    })
                }
            }
    }
}
