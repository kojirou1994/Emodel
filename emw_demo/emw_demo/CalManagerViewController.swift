//
//  CalManagerViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/8/6.
//  Copyright (c) 2015年 emodel. All rights reserved.
//

import UIKit
import JTCalendar
import Foundation

class CalManagerViewController: UIViewController, JTCalendarDelegate {
    
    

    @IBOutlet weak var calendarMenuView: JTCalendarMenuView!
    
    @IBOutlet weak var calendarContentView: JTHorizontalCalendarView!
    
    var minDate = NSDate()
    var maxDate = NSDate()
    var todayDate = NSDate()
    var calendarManager = JTCalendarManager()
    var dateSelected : NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("\(todayDate)")
        println("\(minDate)")
        println("\(maxDate)")
        
        calendarManager.delegate = self
        calendarManager.menuView = calendarMenuView
        calendarManager.contentView = calendarContentView
        calendarManager.setDate(NSDate())
        calendarManager.dateHelper.calendar().timeZone = NSTimeZone(abbreviation: "GMT+0900")!
        calendarManager.dateHelper.calendar().locale = NSLocale(localeIdentifier: "zh")
        minDate = calendarManager.dateHelper.addToDate(todayDate, months: -3)
        maxDate = calendarManager.dateHelper.addToDate(todayDate, months: 3)
        println("\(todayDate)")
        println("\(minDate)")
        println("\(maxDate)")
        calendarManager.reload()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - JTCalendarDelegate
    
    func calendar(calendar: JTCalendarManager!, prepareDayView dayView: UIView!) {
        if let myDayView = dayView as? JTCalendarDayView {
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
            
            
//            if (self.)
        }
        
        
    }
    func calendar(calendar: JTCalendarManager!, didTouchDayView dayView: UIView!) {
        if let myDayView = dayView as? JTCalendarDayView {
            dateSelected = myDayView.date
            println("\(myDayView.date)")
            //Animation
            myDayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
            UIView.transitionWithView(myDayView.circleView, duration: 0.3, options: nil, animations: { () -> Void in
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
    
    func dateFormatter() -> NSDateFormatter {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter

    }
    var eventsByDate: NSMutableDictionary?
    func haveEventForDay(date: NSDate!) ->Bool {
        var key: NSString = self.dateFormatter().stringFromDate(date)
        
//        if (eventsByDate[key] && eventsByDate[key].count > 0) {
//            return true
//        }
        return false
    }
    //MARK: - CalendarManager Delegate  - Page Management
    func calendar(calendar: JTCalendarManager!, canDisplayPageWithDate date: NSDate!) -> Bool {
        return calendarManager.dateHelper.date(todayDate, isEqualOrAfter: minDate, andEqualOrBefore: maxDate)
    }
    func calendarDidLoadNextPage(calendar: JTCalendarManager!) {
        println("calendarDidLoadNextPage")
    }
    func calendarDidLoadPreviousPage(calendar: JTCalendarManager!) {
        println("calendarDidLoadPreviousPage")
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

