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
    @IBAction func removeCalendarButtonTapped(sender: AnyObject) {
        self.removeEMWCalendar()
        self.showSimpleAlert("日历已移除", message: "如需再次添加请点击 导入日历")
    }
    @IBOutlet weak var importCalendarButton: UIButton!
    
    @IBOutlet weak var removeCalendarButton: UIButton!
    var calendars: [EKCalendar]?
    let eventStore = EKEventStore()
    var gotAccessToCalendar: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkCalendarAuthorizationStatus()
        importCalendarButton.layer.masksToBounds = true
        importCalendarButton.layer.cornerRadius = 5
        removeCalendarButton.layer.masksToBounds = true
        removeCalendarButton.layer.cornerRadius = 5
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
        self.showSimpleAlert("同步完毕", message: "日程信息已导入手机")
    }

    func addEMWCalendar() {
        let newCalendar = EKCalendar(forEntityType: .Event, eventStore: eventStore)
        newCalendar.title = "艺模网"
        let sourcesInEventStore = eventStore.sources
        print(sourcesInEventStore)
        newCalendar.source = eventStore.defaultCalendarForNewEvents.source
        var calendarWasSaved: Bool
        do {
            try eventStore.saveCalendar(newCalendar, commit: true)
            calendarWasSaved = true
        } catch let error as NSError {
            print(error)
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
                print("did remove")
                return
            }
        }
        print("remove not find")
    }
    
    func insertEvent(store: EKEventStore) {
        for calendar in store.calendarsForEntityType(.Event) {
            if (calendar.title == "艺模网") {
                print("有艺模网")
                guard let calendarData = localUser.calendar else {
                    return
                }
                for date in calendarData {
                    guard let schedule = date.schedule else {
                        break
                    }
                    for event in schedule {
                        let newEvent = EKEvent(eventStore: store)
                        switch event.timeBucket {
                        case .Morning:
                            newEvent.allDay = false
                            newEvent.startDate = date.date!.dateByAddingTimeInterval(8 * 60 * 60)
                            newEvent.endDate = date.date!.dateByAddingTimeInterval(12 * 60 * 60)
                        case .Afternoon:
                            newEvent.allDay = false
                            newEvent.startDate = date.date!.dateByAddingTimeInterval(12 * 60 * 60)
                            newEvent.endDate = date.date!.dateByAddingTimeInterval(16 * 60 * 60)
                        case .Allday:
                            newEvent.allDay = true
                            newEvent.startDate = date.date!
                            newEvent.endDate = date.date!.dateByAddingTimeInterval(24 * 60 * 60)
                        }
                        newEvent.addAlarm(EKAlarm(relativeOffset: NSTimeInterval(-24 * 60 * 60)))
                        newEvent.title = event.title == nil ? "艺模网活动" : event.title!
                        newEvent.calendar = calendar
                        newEvent.notes = "本日历由艺模网同步，请不要添加私人日历"
                        do {
                            try store.saveEvent(newEvent, span: .ThisEvent)
                        } catch let error {
                            print(error)
                        }
                    }
                }
                return
            }
        }
        print("没有一模网")
    }
}
