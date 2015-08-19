//
//  dataInit.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/10.
//  Copyright (c) 2015年 emodel. All rights reserved.
//
import UIKit

let serverAddress: String! = "http://api.emwcn.com"
//api.emwcn.com
var isLogin: Bool = false
var username: String?
var password: String?
var userId: String? = "55a7abda8a5da518db646c24"
//55a7abda8a5da518db646c18"
var token: String?
var baseInfo: BaseInfoRespData?
var bodyInfo: BodyInfoRespData?
var businessInfo: BusinessInfoRespData?

var album :Array<Album>! = Array<Album>()

/*
从default读取

*/

