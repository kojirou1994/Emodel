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
        print("\(todayDate)")
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
        }
    }
    
//     NSTimeZone *localZone=[NSTimeZone localTimeZone]; NSInteger interval=[localZone secondsFromGMTForDate:date]; NSDate *mydate=[date dateByAddingTimeInterval:interval]; NSLog(@"Date: %@", mydate); } 
    
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
    
    func dateFormatter() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
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
        print("calendarDidLoadNextPage")
    }
    func calendarDidLoadPreviousPage(calendar: JTCalendarManager!) {
        print("calendarDidLoadPreviousPage")
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

