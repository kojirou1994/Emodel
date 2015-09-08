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
        row = XLFormRowDescriptor(tag: BaseInfoTag.QQ.rawValue, rowType: XLFormRowDescriptorTypeInteger, title: "QQ")
        row.value = localUser.baseInfo?.QQ
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        section.addFormRow(row)
        
        // 年龄
        row = XLFormRowDescriptor(tag: BaseInfoTag.Age.rawValue, rowType: XLFormRowDescriptorTypeDecimal, title: "年龄")
        row.value = localUser.baseInfo?.age
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
//        section.addFormRow(row)
        
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
//        section.addFormRow(row)
        
        // 手机号
        row = XLFormRowDescriptor(tag: BaseInfoTag.Mobile.rawValue, rowType: XLFormRowDescriptorTypeInteger, title: "手机号")
        row.value = localUser.baseInfo?.mobile
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
        row.cellConfigAtConfigure["textField.textAlignment"] =  NSTextAlignment.Right.rawValue
        section.addFormRow(row)
        
        // 个人服务
        row = XLFormRowDescriptor(tag: BaseInfoTag.Service.rawValue, rowType: XLFormRowDescriptorTypeText, title: "个人服务")
        row.value = localUser.baseInfo?.service
//        section.addFormRow(row)
        
        
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
    
    func prepareForPUTBody() -> String {
        var body = ""
        if let sex = form.formRowWithTag(BaseInfoTag.Sex.rawValue)!.value as? String {
            body += "sex=\(sex)&"
        }
        else {
            body += "sex=&"
        }
        
        if let nickName = form.formRowWithTag(BaseInfoTag.NickName.rawValue)!.value as? String {
            body += "nickName=\(nickName)&"
        }
        else {
            body += "nickName=&"
        }
        
        if let realName = form.formRowWithTag(BaseInfoTag.RealName.rawValue)!.value as? String {
            body += "realName=\(realName)&"
        }
        else {
            body += "realName=&"
        }
        
        if let QQ = form.formRowWithTag(BaseInfoTag.QQ.rawValue)!.value as? String {
            body += "QQ=\(QQ)&"
        }
        else {
            body += "QQ=&"
        }
        
        if let wechat = form.formRowWithTag(BaseInfoTag.Wechat.rawValue)!.value as? String {
            body += "wechat=\(wechat)&"
        }
        else {
            body += "wechat=&"
        }
        
        if let email = form.formRowWithTag(BaseInfoTag.Email.rawValue)!.value as? String {
            body += "email=\(email)&"
        }
        else {
            body += "email=&"
        }
        
        if let birthday = form.formRowWithTag(BaseInfoTag.Birthday.rawValue)!.value as? NSDate {
            var format = NSDateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            body += "birthday=\(format.stringFromDate(birthday))&"
        }
        else {
            body += "birthday=&"
        }
        
        if let mobile = form.formRowWithTag(BaseInfoTag.Mobile.rawValue)!.value as? String {
            body += "mobile=\(mobile)"
        }
        else {
            body += "mobile="
        }
        return body
    }
    
    
    func savePressed(button: UIBarButtonItem) {
        //提交更新PUT
        println(prepareForPUTBody())
//        let validationErrors : Array<NSError> = self.formValidationErrors() as! Array<NSError>
//        if (validationErrors.count > 0) {
//            self.showFormValidationError(validationErrors.first)
//            return
//        }
//        self.tableView.endEditing(true)
//        println(self.httpParameters())
        
        var re = NSMutableURLRequest(URL: NSURL(string: serverAddress + "/user/" + userId + "/baseinfo")!)
        re.setValue(token, forHTTPHeaderField: "Token")
        re.HTTPMethod = "PUT"
        var str = "sex=男&nickName=king&realName=孝诚&QQ=1234567&wechat=&email=test@qq.com&birthday=1992-09-01&mobile=13916530237"
        re.HTTPBody = str.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(re, completionHandler: { (data, response, error) -> Void in
            println(response)
        })
//        task.resume()
        sendRequest()
//
//        let params: Dictionary = self.formValues()
//        println("params:")
//        println(params)
//        var format = NSDateFormatter()
//        format.dateFormat = "yyyy-MM-dd"
//        
//
//        var update = HTTPTask()
//        update.requestSerializer = HTTPRequestSerializer()
//        update.requestSerializer.headers["Token"] = token
//        let para: Dictionary<String, AnyObject> = ["realName": form.formRowWithTag("realName")!.value!, "nickName": form.formRowWithTag("nickName")!.value!,"birthday": form.formRowWithTag("birthday")!.value!, "QQ": form.formRowWithTag("QQ")!.value!, "wechat": form.formRowWithTag("wechat")!.value!, "sex": form.formRowWithTag("sex")!.value!, "email": form.formRowWithTag("email")!.value!, "mobile": form.formRowWithTag("mobile")!.value!]
//        update.PUT(serverAddress + "/user/" + userId + "/baseinfo", parameters: para) { (response: HTTPResponse) -> Void in
//            if let err = response.error {
//                println("delete photo error \(err)")
//                return
//            }
//            if let obj: AnyObject = response.responseObject {
//                println(obj)
//            }
//        }
//
//        let alertView = UIAlertView(title: "更新成功", message: "okokokok", delegate: self, cancelButtonTitle: "OK")
//        alertView.show()

    }
}


    func sendRequest() {
        /* Configure session, choose between:
        * defaultSessionConfiguration
        * ephemeralSessionConfiguration
        * backgroundSessionConfigurationWithIdentifier:
        And set session-wide properties, such as: HTTPAdditionalHeaders,
        HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
        */
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        /* Create session, and optionally set a NSURLSessionDelegate. */
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        /* Create the Request:
        BaseInfo Duplicate (PUT http://10.0.1.11/user/55a7abda8a5da518db646c18/baseinfo)
        */
        
        var URL = NSURL(string: "http://10.0.1.11/user/55a7abda8a5da518db646c18/baseinfo")
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "PUT"
        
        // Headers
        
        request.addValue("eyJhbGciOiJIUzI1NiIsImV4cCI6MTQ0MjI5NzI0NSwiaWF0IjoxNDQxNjkyNDQ1fQ.eyJ1c2VySWQiOiI1NWE3YWJkYThhNWRhNTE4ZGI2NDZjMTgifQ.VhKQHfGkOSqQuDEnsqFIhSkIZ51CjR38MzxrVsFIyDk", forHTTPHeaderField: "Token")
        
        // Form URL-Encoded Body
        
        let bodyParameters = [
            "email": "Ios@qq.com",
            "QQ": "123",
            "realName": "iOS",
        ]
        let bodyString = stringFromQueryParameters(bodyParameters)
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        /* Start a new Task */
        let task = session.dataTaskWithRequest(request, completionHandler: { (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                println("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                println("URL Session Task Failed: %@", error.localizedDescription);
            }
        })
        task.resume()
    }
    
    /**
    This creates a new query parameters string from the given NSDictionary. For
    example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
    string will be @"day=Tuesday&month=January".
    @param queryParameters The input dictionary.
    @return The created parameters string.
    */
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
    
    /**
    Creates a new URL by adding the given query parameters.
    @param URL The input URL.
    @param queryParameters The query parameter dictionary to add.
    @return A new NSURL.
    */
    func NSURLByAppendingQueryParameters(URL : NSURL!, queryParameters : Dictionary<String, String>) -> NSURL {
        let URLString : NSString = NSString(format: "%@?%@", URL.absoluteString!, stringFromQueryParameters(queryParameters))
        return NSURL(string: URLString as String)!
    }
