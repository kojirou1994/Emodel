//
//  CalendarManagerViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/10/19.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import CVCalendar
import Alamofire

class CalendarManagerViewController: UIViewController {

    @IBOutlet weak var menuView: CVCalendarMenuView!
    
    @IBOutlet weak var calendarView: CVCalendarView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var freeDateButton: UIButton!
    
    @IBOutlet weak var fullDateButton: UIButton!
    
    @IBAction func freeDateButtonTapped(sender: AnyObject) {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        Alamofire.request(.POST, serverAddress + "/user/" + userId + "/calendar", parameters: ["title": "休息日","body": "", "date": format.stringFromDate(calendarView.presentedDate.convertedDate()!.dateByAddingTimeInterval(8 * 60 * 60)),"type": "custom","timeBucket": 16777215], encoding: ParameterEncoding.JSON, headers: ["Token": token])
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
    
    @IBAction func fullDateButtonTapped(sender: AnyObject) {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        Alamofire.request(.POST, serverAddress + "/user/" + userId + "/calendar", parameters: ["title": "其他预约","body": "", "date": format.stringFromDate(calendarView.presentedDate.convertedDate()!.dateByAddingTimeInterval(8 * 60 * 60)), "type": "work", "timeBucket": 16777215], encoding: ParameterEncoding.JSON, headers: ["Token": token])
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
    
    var monthLabel: UILabel!
    var shouldShowDaysOut = true
    var animationFinished = true
    var selectedDate: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = true
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        monthLabel = UILabel()
        self.navigationItem.titleView = monthLabel
        self.presentedDateUpdated(CVDate(date: NSDate()))
        if (localUser.calendar != nil) {
            localUser.calendar!.sortInPlace({ (T, U) -> Bool in
                let format = NSDateFormatter()
                format.dateFormat = "yyyy-MM-dd"
                return T.date!.timeIntervalSinceDate(U.date!) < 0
            })
        }
        self.tableView.registerNib(UINib(nibName: "CMTableViewCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        let btn = UIBarButtonItem(title: "同步", style: UIBarButtonItemStyle.Plain, target: self, action: "toSyncVC")
        self.navigationItem.rightBarButtonItem = btn
//        self.tabBarController?.tab
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    func toSyncVC() {
        self.navigationController?.pushViewController(CalendarSyncViewController(), animated: true)
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
                        return T.date!.timeIntervalSinceDate(U.date!) < 0
                    })
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            case .Failure(_, _):
                print("error")
            }
        }
    }

}


// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate

extension CalendarManagerViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    // MARK: Optional methods
    
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    func didSelectDayView(dayView: CVCalendarDayView) {
        let date = dayView.date
//        print(calendarView.presentedDate.convertedDate())
//        print(date.convertedDate()!.dateByAddingTimeInterval(8 * 60 * 60))
//        print("\(calendarView.presentedDate.commonDescription) is selected!")
    }
    
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return true
    }
    
    func presentedDateUpdated(date: CVDate) {
        
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            //            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            //            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                //                updatedMonthLabel.alpha = 1
                //                updatedMonthLabel.transform = CGAffineTransformIdentity
                
                }) { _ in
                    
                    self.animationFinished = true
                    self.monthLabel.frame = updatedMonthLabel.frame
                    self.monthLabel.text = updatedMonthLabel.text
                    self.monthLabel.transform = CGAffineTransformIdentity
                    self.monthLabel.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date.day
        let randomDay = Int(arc4random_uniform(31))
        if day == randomDay {
            return true
        }
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        let day = dayView.date.day
        
        let red = CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(arc4random_uniform(600) / 255)
        let blue = CGFloat(arc4random_uniform(600) / 255)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let numberOfDots = Int(arc4random_uniform(3) + 1)
        switch(numberOfDots) {
        case 2:
            return [color, color]
        case 3:
            return [color, color, color]
        default:
            return [color] // return 1 dot
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 13
    }
    
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .Short
    }
    
}

// MARK: - CVCalendarViewAppearanceDelegate

extension CalendarManagerViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}

// MARK: - Convenience API Demo

extension CalendarManagerViewController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(NSDate()) // from today
        
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
}


// MARK: - UITableViewDelegate
extension CalendarManagerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return localUser.calendar == nil ? 0 : (localUser.calendar?.count)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let calendar = localUser.calendar?[section] else {
            return 0
        }
        return calendar.schedule == nil ? 0 : (calendar.schedule?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as! CMTableViewCell
        cell.eventTimeLabel.text = localUser.calendar![indexPath.section].schedule![indexPath.row].timeBucket.rawValue
        cell.eventTitleLabel.text = localUser.calendar![indexPath.section].schedule![indexPath.row].title == nil ? "无标题" : localUser.calendar![indexPath.section].schedule![indexPath.row].title
        if (cell.eventTitleLabel.text == "") {
            cell.eventTitleLabel.text = "无标题"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        return format.stringFromDate(localUser.calendar![section].date!)
    }
}