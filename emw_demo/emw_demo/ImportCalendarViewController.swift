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
        self.checkCalendarAuthorizationStatus()
    }
    
    var calendars: [EKCalendar]?
    let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            self.requestAccessToCalendar()
        case EKAuthorizationStatus.Authorized:
            self.insertEvent(eventStore)
        case EKAuthorizationStatus.Restricted, EKAuthorizationStatus.Denied:
            print("alert")
        default:
            print("oh no")
        }
    }
    
    func requestAccessToCalendar() {
        eventStore.requestAccessToEntityType(EKEntityType.Event) { (accessGranted, error) -> Void in
            print(accessGranted)
            if (accessGranted) {
                self.insertEvent(self.eventStore)
            }
            else {
                
            }
        }
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
    
    func insertEvent(store: EKEventStore) {
        for calendar in store.calendarsForEntityType(.Event) {
            if (calendar.title == "艺模网") {
                print("有艺模网")
                for event in localUser.calendar! {
                    let format = NSDateFormatter()
                    format.dateFormat = "yyyy-MM-dd"
                    let startDate = format.dateFromString(event.date!)!.dateByAddingTimeInterval(8 * 60 * 60)
                    let endDate = startDate.dateByAddingTimeInterval(9 * 60 * 60)
                    
                    let newEvent = EKEvent(eventStore: store)
                    newEvent.title = event.schedule!.title
                    newEvent.calendar = calendar
                    newEvent.startDate = startDate
                    newEvent.endDate = endDate
                    do {
                        try store.saveEvent(newEvent, span: .ThisEvent)
                    } catch let _ {
                        
                    }
                }
                return
            }
        }
        print("没有一模网")
        self.addEMWCalendar()
//        print()
    }
}
