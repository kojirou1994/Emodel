//
//  UserData.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/6.
//  Copyright (c) 2015年 emodel. All rights reserved.
//
import XLForm

class BaseInfoEditViewController : XLFormViewController {
    
    private enum Tags : String {
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
        row = XLFormRowDescriptor(tag: Tags.QQ.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "QQ")
        row.value = localUser?.baseInfo?.QQ
        section.addFormRow(row)
        
        // 年龄
        row = XLFormRowDescriptor(tag: Tags.Age.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "年龄")
        row.value = localUser?.baseInfo?.age
        section.addFormRow(row)
        
        // 生日
        row = XLFormRowDescriptor(tag: Tags.Birthday.rawValue, rowType: XLFormRowDescriptorTypeDateInline, title: "生日")
        row.value = NSDate()
        section.addFormRow(row)
        
        // 邮箱
        row = XLFormRowDescriptor(tag: Tags.Email.rawValue, rowType: XLFormRowDescriptorTypeEmail, title: "邮箱")
        row.value = localUser?.baseInfo?.email
        section.addFormRow(row)
        
        // 个人简介
        row = XLFormRowDescriptor(tag: Tags.Introduction.rawValue, rowType: XLFormRowDescriptorTypeTextView, title: "个人简介")
        row.value = localUser?.baseInfo?.introduction
        section.addFormRow(row)
        
        // 手机号
        row = XLFormRowDescriptor(tag: Tags.Mobile.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "手机号")
        row.value = localUser?.baseInfo?.mobile!
        section.addFormRow(row)
        
        // 用户名
        row = XLFormRowDescriptor(tag: Tags.NickName.rawValue, rowType: XLFormRowDescriptorTypeText, title: "用户名")
        row.value = localUser?.baseInfo?.nickName
        section.addFormRow(row)
        
        // 真实姓名
        row = XLFormRowDescriptor(tag: Tags.RealName.rawValue, rowType: XLFormRowDescriptorTypeText, title: "真实姓名")
        row.value = localUser.baseInfo?.realName
        section.addFormRow(row)
        
        // 个人服务
        row = XLFormRowDescriptor(tag: Tags.Service.rawValue, rowType: XLFormRowDescriptorTypeText, title: "个人服务")
        row.value = localUser.baseInfo?.service
        section.addFormRow(row)
        
        
        // 性别
        row = XLFormRowDescriptor(tag: Tags.Sex.rawValue, rowType: XLFormRowDescriptorTypeText, title: "性别")
        row.value = localUser.baseInfo?.sex
        section.addFormRow(row)
        
        // 微信账号
        row = XLFormRowDescriptor(tag: Tags.Wechat.rawValue, rowType: XLFormRowDescriptorTypeText, title: "微信账号")
        row.value = localUser?.baseInfo?.wechat
        section.addFormRow(row)
        
        self.form = form
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "savePressed:")
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
