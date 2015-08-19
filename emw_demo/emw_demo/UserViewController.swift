//
//  UserViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import JSONJoy
import SwiftHTTP
import Kingfisher

var rank:Int?
class UserViewController: UITableViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var starRank: UIImageView!
    @IBOutlet weak var headImage: UIImageView!
    var ass = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.redColor()
        ass.center = CGPointMake(userNameLabel.frame.minX+10, userNameLabel.frame.maxY)
        //        ass.frame = CGRectMake(100, 100, 100, 100)
        self.view.addSubview(ass)
        //        ass.bounds = CGRectMake(100, 100, 100, 100)
//        ass.color = UIColor.yellowColor()
        ass.startAnimating()
        
        var request = HTTPTask()
        println("start get baseinfo")
        request.GET(serverAddress + "/user/\(userId!)/baseinfo", parameters: nil) { (response: HTTPResponse) -> Void in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                let resp = BaseInfoResp(JSONDecoder(obj))
                println("status is: \(resp.status!)")
                println("QQ is:\(resp.data!.QQ!)")
                println("realName is:\(resp.data!.realName!)")
                baseInfo = resp.data
                dispatch_async(dispatch_get_main_queue(),{
                self.headImage.kf_setImageWithURL(NSURL(string: resp.data!.avatar!)!)
                self.userNameLabel.text = resp.data!.nickName!
                self.ass.stopAnimating()
                })
//                self.starRank.image = UIImage(named: "starRank_\(resp.data?.!).png") 更新评分
            }
        }
        println("start get bodyinfo")
        request.GET(serverAddress + "/user/\(userId!)/bodyinfo", parameters: nil) { (response: HTTPResponse) -> Void in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                let resp = BodyInfoResp(JSONDecoder(obj))
                bodyInfo = resp.data
                println("bodyinfo.height:\(bodyInfo?.height)")
            }
        }
        println("start get businessinfo")
        request.GET(serverAddress + "/user/\(userId!)/businessinfo", parameters: nil) { (response: HTTPResponse) -> Void in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                let resp = BusinessInfoResp(JSONDecoder(obj))
                businessInfo = resp.data
            }
        }
        println("start get albuminfo")
        request.GET(serverAddress + "/user/\(userId!)/albuminfo", parameters: nil) { (response: HTTPResponse) -> Void in
            if let err = response.error {
                println("error: \(err.localizedDescription)")
                return
            }
            if let obj: AnyObject = response.responseObject {
                let resp = AlbumInfoResp(JSONDecoder(obj))
                album = resp.data
                println("album count: \(album.count)")
                println("album1 num: \(album[0].num)")
                println("album2 ID: \(album[1].id)")
                
                
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.purpleColor()
        
    }
    override func viewDidAppear(animated: Bool) {
        println("kingking")
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
