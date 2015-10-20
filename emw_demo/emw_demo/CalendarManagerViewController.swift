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
        
    }
    
    @IBAction func fullDateButtonTapped(sender: AnyObject) {
        
    }
    
    var monthLabel: UILabel!
    var shouldShowDaysOut = true
    var animationFinished = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
//        self.tabBarController?.setTabBarVisible(true, animated: true)
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
        print("\(calendarView.presentedDate.commonDescription) is selected!")
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

// MARK: - IB Actions

extension CalendarManagerViewController {
    @IBAction func switchChanged(sender: UISwitch) {
        if sender.on {
            calendarView.changeDaysOutShowingState(false)
            shouldShowDaysOut = true
        } else {
            calendarView.changeDaysOutShowingState(true)
            shouldShowDaysOut = false
        }
    }
    
    @IBAction func todayMonthView() {
        calendarView.toggleCurrentDayView()
    }
    
    /// Switch to WeekView mode.
    @IBAction func toWeekView(sender: AnyObject) {
        calendarView.changeMode(.WeekView)
    }
    
    /// Switch to MonthView mode.
    @IBAction func toMonthView(sender: AnyObject) {
        calendarView.changeMode(.MonthView)
    }
    
    @IBAction func loadPrevious(sender: AnyObject) {
        calendarView.loadPreviousView()
    }
    
    
    @IBAction func loadNext(sender: AnyObject) {
        calendarView.loadNextView()
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

extension UITabBarController {
    func setTabBarVisible(visible:Bool, animated:Bool) {
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        UIView.animateWithDuration(animated ? 0.3 : 0.0) {
            self.tabBar.frame = CGRectOffset(frame, 0, offsetY)
            self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }
    }
}