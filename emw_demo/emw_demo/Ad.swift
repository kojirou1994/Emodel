//
//  Ad.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/26.
//  Copyright © 2015年 emodel. All rights reserved.
//


import Foundation

struct Ad: JSONJoy {
    
    var female: [String]?
    var male: [String]?
    var femaleW: [String]?
    var maleW: [String]?
    var old: [String]?
    var young: [String]?
    subscript (index: Int) -> [String]? {
        get {
            return nil
        }
    }
    func users(index: Int) -> [String]? {
        switch index {
        case 0:
            return female
        case 1:
            return male
        case 2:
            return femaleW
        case 3:
            return maleW
        case 4:
            return young
        case 5:
            return old
        default:
            return nil
        }
    }
    init(_ decoder: JSONDecoder) {
        
        if let data = decoder["data"]["26"].array {
            female = [String]()
            for user in data {
                if let id = user["modelId"].string {
                    female?.append(id)
                }
            }
        }
        if let data = decoder["data"]["27"].array {
            if female == nil {
                female = [String]()
            }
            for user in data {
                if let id = user["modelId"].string {
                    female?.append(id)
                }
            }
        }
        
        if let data = decoder["data"]["28"].array {
            male = [String]()
            for user in data {
                if let id = user["modelId"].string {
                    male?.append(id)
                }
            }
        }
        if let data = decoder["data"]["29"].array {
            if male == nil {
                male = [String]()
            }
            for user in data {
                if let id = user["modelId"].string {
                    male?.append(id)
                }
            }
        }
        
        if let data = decoder["data"]["30"].array {
            femaleW = [String]()
            for user in data {
                if let id = user["modelId"].string {
                    femaleW?.append(id)
                }
            }
        }
        if let data = decoder["data"]["31"].array {
            if femaleW == nil {
                femaleW = [String]()
            }
            for user in data {
                if let id = user["modelId"].string {
                    femaleW?.append(id)
                }
            }
        }
        
        if let data = decoder["data"]["32"].array {
            maleW = [String]()
            for user in data {
                if let id = user["modelId"].string {
                    maleW?.append(id)
                }
            }
        }
        if let data = decoder["data"]["33"].array {
            if maleW == nil {
                maleW = [String]()
            }
            print(data)
            for user in data {
                if let id = user["modelId"].string {
                    maleW?.append(id)
                }
            }
        }
        
        if let data = decoder["data"]["34"].array {
            young = [String]()
            for user in data {
                if let id = user["modelId"].string {
                    young?.append(id)
                }
            }
        }
        if let data = decoder["data"]["35"].array {
            if young == nil {
                young = [String]()
            }
            print(data)
            for user in data {
                if let id = user["modelId"].string {
                    young?.append(id)
                }
            }
        }
        
        if let data = decoder["data"]["36"].array {
            old = [String]()
            for user in data {
                if let id = user["modelId"].string {
                    old?.append(id)
                }
            }
        }
        if let data = decoder["data"]["37"].array {
            if old == nil {
                old = [String]()
            }
            print(data)
            for user in data {
                if let id = user["modelId"].string {
                    old?.append(id)
                }
            }
        }
    }

}