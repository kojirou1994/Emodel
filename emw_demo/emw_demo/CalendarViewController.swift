//
//  CalManagerViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/6.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import JTCalendar
import Alamofire

class CalManagerViewController: UIViewController, JTCalendarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var calendarMenuView: JTCalendarMenuView!
    
    @IBOutlet weak var calendarTableView: UITableView!
    @IBOutlet weak var calendarContentView: JTHorizontalCalendarView!
    @IBAction func setThisDayFreeButtonTapped(sender: AnyObject) {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        Alamofire.request(.POST, serverAddress + "/user/" + userId + "/calendar", parameters: ["title": "休息日","body": "", "date": format.stringFromDate(dateSelected!),"type": "custom","timeBucket": 16777215], encoding: ParameterEncoding.JSON, headers: ["Token": token])
        .validate()
        .responseJSON { (_, _, result) -> Void in
            switch (result) {
            case .Success(_):
                dispatch_async(dispatch_get_main_queue(), {
                    self.updateCalendarInfo()
                    self.showSimpleAlert("设置成功", message: "")
                })
            case .Failure(_, _):
                dispatch_async(dispatch_get_main_queue(), {
                    self.showSimpleAlert("设置失败", message: "")
                })
            }
        }
    }
    
    @IBAction func setThisDayFullButtonTapped(sender: AnyObject) {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        Alamofire.request(.POST, serverAddress + "/user/" + userId + "/calendar", parameters: ["title": "其他预约","body": "", "date": format.stringFromDate(dateSelected!),"type": "work","timeBucket": 16777215], encoding: ParameterEncoding.JSON, headers: ["Token": token])
            .validate()
            .responseJSON { (_, _, result) -> Void in
                switch (result) {
                case .Success(_):
                    dispatch_async(dispatch_get_main_queue(), {
                        self.updateCalendarInfo()
                        self.showSimpleAlert("设置成功", message: "")
                    })
                case .Failure(_, _):
                    dispatch_async(dispatch_get_main_queue(), {
                        self.showSimpleAlert("设置失败", message: "")
                    })
                }
        }
    }
    
    var minDate = NSDate()
    var maxDate = NSDate()
    var todayDate = NSDate()
    var calendarManager = JTCalendarManager()
    var dateSelected: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateSelected = todayDate
        print("\(todayDate)")
        print(localUser.calendar)
        calendarManager.delegate = self
        calendarManager.menuView = calendarMenuView
        calendarManager.contentView = calendarContentView
        calendarManager.setDate(NSDate())
        minDate = calendarManager.dateHelper.addToDate(todayDate, months: -3)
        maxDate = calendarManager.dateHelper.addToDate(todayDate, months: 3)
        print("\(todayDate)")
        print("\(minDate)")
        print("\(maxDate)")
        calendarManager.reload()
        if (localUser.calendar != nil) {
            localUser.calendar!.sortInPlace({ (T, U) -> Bool in
                let format = NSDateFormatter()
                format.dateFormat = "yyyy-MM-dd"
                return format.dateFromString(T.date!)!.timeIntervalSinceDate(format.dateFromString(U.date!)!) < 0
            })
        }
        self.calendarTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    
    func updateCalendarInfo() {
        Alamofire.request(.GET, serverAddress + "/user/" + userId + "/calendar")
        .validate()
        .responseJSON { (_, _, result) -> Void in
            switch (result) {
            case .Success(_):
                localUser.calendar = CalendarResp(JSONDecoder(result.value!)).data
                if (localUser.calendar != nil) {
                    localUser.calendar!.sortInPlace({ (T, U) -> Bool in
                        let format = NSDateFormatter()
                        format.dateFormat = "yyyy-MM-dd"
                        return format.dateFromString(T.date!)!.timeIntervalSinceDate(format.dateFromString(U.date!)!) < 0
                    })
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.calendarTableView.reloadData()
                })
            case .Failure(_, _):
                print("error")
            }
        }
    }
    
    //MARK: - JTCalendarDelegate
    
    func calendar(calendar: JTCalendarManager!, prepareDayView dayView: UIView!) {
        if let myDayView = dayView as? JTCalendarDayView {
//            if (self.haveEventForDay(myDayView.date.dateByAddingTimeInterval(NSTimeInterval(NSTimeZone.localTimeZone().secondsFromGMTForDate(myDayView.date))))) {
//                print(myDayView.date)
//                print("有安排")
//            }
//            else {
//                print("没有安排")
//            }
            if (calendarManager.dateHelper.date(NSDate(), isTheSameDayThan: myDayView.date)) {
                myDayView.circleView.hidden = false
                myDayView.circleView.backgroundColor = UIColor.blueColor()
                myDayView.dotView.backgroundColor = UIColor.whiteColor()
                myDayView.textLabel.textColor = UIColor.whiteColor()
            }
            else if ((dateSelected != nil) && calendarManager.dateHelper.date(dateSelected, isTheSameDayThan: myDayView.date)) {
                myDayView.circleView.hidden = false
                myDayView.circleView.backgroundColor = UIColor.redColor()
                myDayView.dotView.backgroundColor = UIColor.whiteColor()
                myDayView.textLabel.textColor = UIColor.whiteColor()
            }
            else if (!calendarManager.dateHelper.date(calendarContentView.date, isTheSameMonthThan: myDayView.date)) {
                myDayView.circleView.hidden = true
                myDayView.dotView.backgroundColor = UIColor.redColor()
                myDayView.textLabel.textColor = UIColor.lightGrayColor()
            }
            else {
                myDayView.circleView.hidden = true
                myDayView.dotView.backgroundColor = UIColor.redColor()
                myDayView.textLabel.textColor = UIColor.blackColor()
            }
        }
    }
    
    func calendar(calendar: JTCalendarManager!, didTouchDayView dayView: UIView!) {
        if let myDayView = dayView as? JTCalendarDayView {
            let localZone = NSTimeZone.localTimeZone()
            let interval: NSInteger = localZone.secondsFromGMTForDate(myDayView.date)
            dateSelected = myDayView.date.dateByAddingTimeInterval(NSTimeInterval(interval))
            print("\(dateSelected)")
            //Animation
            myDayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
            UIView.transitionWithView(myDayView.circleView, duration: 0.3, options: [], animations: { () -> Void in
                myDayView.circleView.transform = CGAffineTransformIdentity
                self.calendarManager.reload()
            }, completion: nil)
            calendarManager.reload()
            
            //点到下/上个月的日期自动跳过去
            if (!calendarManager.dateHelper.date(calendarContentView.date, isTheSameMonthThan: myDayView.date)) {
                if (calendarContentView.date.compare(myDayView.date) == NSComparisonResult.OrderedAscending) {
                    calendarContentView.loadNextPageWithAnimation()
                }
                else {
                    calendarContentView.loadPreviousPageWithAnimation()
                }
            }
        }
    }
    
    var eventsByDate: NSMutableDictionary?
    func haveEventForDay(date: NSDate!) ->Bool {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if (localUser.calendar == nil) {
            return false
        }
        for singleCalendar in localUser.calendar! {
            if (singleCalendar.date! == dateFormatter.stringFromDate(date)) {
                return true
            }
        }
        return false
    }
    //MARK: - CalendarManager Delegate  - Page Management
    func calendar(calendar: JTCalendarManager!, canDisplayPageWithDate date: NSDate!) -> Bool {
        return calendarManager.dateHelper.date(todayDate, isEqualOrAfter: minDate, andEqualOrBefore: maxDate)
    }
    func calendarDidLoadNextPage(calendar: JTCalendarManager!) {
        print("calendarDidLoadNextPage")
    }
    func calendarDidLoadPreviousPage(calendar: JTCalendarManager!) {
        print("calendarDidLoadPreviousPage")
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localUser.calendar == nil ? 0 : (localUser.calendar?.count)!
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CalendarCell") as! CalendarTableViewCell
        cell.timeLabel.text = "时间: " + (localUser.calendar![indexPath.row].date == nil ? "无" : localUser.calendar![indexPath.row].date!)
        cell.titleLabel.text = "安排: " + (localUser.calendar![indexPath.row].schedule?.title! == "" ? "工作" : (localUser.calendar![indexPath.row].schedule?.title)!)
        cell.bodyLabel.text = "备注: " + (localUser.calendar![indexPath.row].schedule?.body! == "" ? "无" : (localUser.calendar![indexPath.row].schedule?.body)!)
        cell.userInteractionEnabled = false
        return cell
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

