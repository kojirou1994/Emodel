//
//  FirstViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/1.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit

class PublicNoticeViewController: UIViewController, UINavigationControllerDelegate, SMSegmentViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var notices = [Notice]()
    
    var segmentView: SMSegmentView!
    var margin: CGFloat = 10.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentView = SMSegmentView(frame: CGRect(x: self.margin, y: 100.0, width: self.view.frame.size.width - self.margin*16, height: 30.0), separatorColour: UIColor(white: 0.95, alpha: 0.3), separatorWidth: 0.5, segmentProperties: [keySegmentTitleFont: UIFont.systemFontOfSize(12.0), keySegmentOnSelectionColour: UIColor(red: 245.0/255.0, green: 174.0/255.0, blue: 63.0/255.0, alpha: 1.0), keySegmentOffSelectionColour: UIColor.whiteColor(), keyContentVerticalMargin: Float(10.0)])
        
        self.segmentView.delegate = self
        
        self.segmentView.layer.cornerRadius = 5.0
        self.segmentView.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).CGColor
        self.segmentView.layer.borderWidth = 1.0
        
        // Add segments
        self.segmentView.addSegmentWithTitle("通告广场", onSelectionImage: UIImage(named: "clip_light"), offSelectionImage: UIImage(named: "clip"))
        self.segmentView.addSegmentWithTitle("我的通告", onSelectionImage: UIImage(named: "bulb_light"), offSelectionImage: UIImage(named: "bulb"))
        self.navigationItem.titleView = segmentView
        segmentView.selectSegmentAtIndex(0)
//        self.hidesBottomBarWhenPushed = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func initializeTheNotices() {
        self.notices = [Notice(title: "拍片", thumbnails: "img.jpg", status: "报名中", time: "1200am", price: "200$", location: "杭州"),
            Notice(title: "拍片", thumbnails: "img.jpg", status: "已结束", time: "1200am", price: "200$", location: "杭州"),
            Notice(title: "拍片", thumbnails: "img.jpg", status: "已结束", time: "1200am", price: "200$", location: "杭州"),
            Notice(title: "拍片", thumbnails: "img.jpg", status: "已结束", time: "1200am", price: "200$", location: "杭州")]
        self.tableView?.reloadData()
        
    }
    // SMSegment Delegate
    func segmentView(segmentView: SMSegmentView, didSelectSegmentAtIndex index: Int) {
        if index == 0 {
            initializeTheNotices()
            //通告广场
        }
        else {
            //我的通告
            println(notices[0].title)
            println(notices.count)
        }

        println("Select segment at index: \(index)")
    }
    
    
    // MARK: - UITableView DataSource Methods

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "noticeTableCell"
        
        var cell: NoticeTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? NoticeTableCell
        
        if cell == nil {
            cell = NoticeTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        cell.configurateTheCell(notices[indexPath.row])
        println(cell.timeLabel?.text)
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("count\(notices.count)")
        return notices.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    
    //MARK: - UITableView Delegate Method
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "noticeDetail" {
            let indexPath = self.tableView!.indexPathForSelectedRow
            let destinationViewController: NoticeDetailViewController = segue.destinationViewController as! NoticeDetailViewController

//            destinationViewController.prepString = recipes[indexPath()!.row].prepTime
//            destinationViewController.nameString = recipes[indexPath()!.row].name
//            destinationViewController.imageName = recipes[indexPath()!.row].thumbnails
        }
    }
    
    /*
    隐藏tabbar
    func makeTabBarHidden(hide: BOOL) {
        if self.tabBarController.view.subviews.count <2 {
            return
        }
        var contentView:UIView!
        if self.tabBarController.view.subviews.
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
    contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else
    {
    contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    //    [UIView beginAnimations:@"TabbarHide" context:nil];
    if ( hide )
    {
    contentView.frame = self.tabBarController.view.bounds;
    }
    else
    {
    contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
    self.tabBarController.view.bounds.origin.y,
    self.tabBarController.view.bounds.size.width,
    self.tabBarController.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    }
    
    self.tabBarController.tabBar.hidden = hide;
    }
*/
}

