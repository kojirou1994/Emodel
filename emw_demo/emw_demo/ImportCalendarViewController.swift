//
//  ImportCalendarViewController.swift
//  emw_demo
//
//  Created by 王宇 on 15/9/28.
//  Copyright © 2015年 emodel. All rights reserved.
//

import UIKit
import EventKit

class ImportCalendarViewController: UIViewController {

    @IBAction func importCalendarButtonTapped(sender: AnyObject) {
        if (gotAccessToCalendar) {
            self.syncEMWCalendar()
        }
        else {
            self.showSimpleAlert("fail", message: "no right")
        }
    }
    
    var calendars: [EKCalendar]?
    let eventStore = EKEventStore()
    var gotAccessToCalendar: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkCalendarAuthorizationStatus()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatusForEntityType(EKEntityType.Event)
        print(status)
        switch (status) {
        case EKAuthorizationStatus.NotDetermined:
            //没获取权限，申请获取
            self.requestAccessToCalendar()
        case EKAuthorizationStatus.Authorized:
            //已经获取不执行
            self.gotAccessToCalendar = true
        case EKAuthorizationStatus.Restricted, EKAuthorizationStatus.Denied:
            print("alert")
            self.showSimpleAlert("没获取日历权限", message: "请去设置中设置")
        }
    }
    
    func requestAccessToCalendar() {
        eventStore.requestAccessToEntityType(.Event) { (accessGranted, error) -> Void in
            print(accessGranted)
            if (accessGranted) {
                self.gotAccessToCalendar = true
            }
            else {
                self.gotAccessToCalendar = false
            }
        }
    }
    func syncEMWCalendar() {
        removeEMWCalendar()
        addEMWCalendar()
        insertEvent(eventStore)
    }

    func addEMWCalendar() {
        let newCalendar = EKCalendar(forEntityType: .Event, eventStore: eventStore)
        newCalendar.title = "艺模网"
        let sourcesInEventStore = eventStore.sources
        newCalendar.source = sourcesInEventStore.filter({ (source) -> Bool in
            source.sourceType == EKSourceType.Local
        }).first!
        
        var calendarWasSaved: Bool
        do {
            try eventStore.saveCalendar(newCalendar, commit: true)
            calendarWasSaved = true
        } catch let error as NSError {
            calendarWasSaved = false
        }
        print("add Calendar")
        print(calendarWasSaved)
    }
    
    func removeEMWCalendar() {
        for calendar in eventStore.calendarsForEntityType(.Event) {
            if (calendar.title == "艺模网") {
                do {
                    try eventStore.removeCalendar(calendar, commit: true)
                }catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func insertEvent(store: EKEventStore) {
        for calendar in store.calendarsForEntityType(.Event) {
            if (calendar.title == "艺模网") {
                print("有艺模网")
                if (localUser.calendar == nil) {
                    return
                }
                for event in localUser.calendar! {
                    let format = NSDateFormatter()
                    format.dateFormat = "yyyy-MM-dd"
                    let startDate = format.dateFromString(event.date!)!.dateByAddingTimeInterval(8 * 60 * 60)
                    let endDate = startDate.dateByAddingTimeInterval(9 * 60 * 60)
                    
                    let newEvent = EKEvent(eventStore: store)
                    newEvent.title = event.schedule!.title == "" ? "艺模网事件" : event.schedule!.title
                    newEvent.calendar = calendar
                    newEvent.startDate = startDate
                    newEvent.endDate = endDate
                    newEvent.notes = "本日历由艺模网同步，请不要添加私人日历"
                    do {
                        try store.saveEvent(newEvent, span: .ThisEvent)
                    } catch let _ {
                        
                    }
                }
                return
            }
        }
        print("没有一模网")
    }
}
