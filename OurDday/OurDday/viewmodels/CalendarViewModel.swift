////
////  CalendarViewModel.swift
////  OurDday
////
////  Created by rae on 2022/04/04.
////
//
//import Foundation
//
//class CalendarViewModel: NSObject {
//        
//    private var selectDate = Date()
//    private var calendarEvents = [CalendarEvent]()
//    
//    func updateSelectDate(date: Date) {
//        selectDate = date
//    }
//    
//    func updateCalendarEvents() {
//        calendarEvents = RealmManager.shared.readCalendarEvent().filter {$0.date.toCalendarDateString() == selectDate.toCalendarDateString()}
//    }
//    
//    func calendarSelectDate() -> Date {
//        return selectDate
//    }
//    
//    func calendarEventsCount() -> Int {
//        return calendarEvents.count
//    }
//    
//    func calendarEvent(at index: Int) -> CalendarEvent {
//        return calendarEvents[index]
//    }
//    
//    func calendarNumberOfSections() -> Int {
//        return 1
//    }
//    
//    func calendarTitleHeaderInSection() -> String {
//        let count = Calendar.countDaysFromNow(fromDate: selectDate)
//        
//        if count == 0 {
//            return "오늘"
//        } else if count > 0 {
//            return "D+\(abs(count))"
//        } else {
//            return "D\(count)"
//        }
//    }
//}
