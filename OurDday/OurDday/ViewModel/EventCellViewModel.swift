//
//  EventCellViewModel.swift
//  OurDday
//
//  Created by rae on 2022/02/24.
//

import Foundation

struct EventCellViewModel {
    let event: Event
    let calendar: Calendar
    let firstDayDate: Date
    
    init(event: Event) {
        self.event = event
        self.calendar = Calendar.current
        self.firstDayDate = RealmManager.shared.readFirstDayDate()
    }
    
    var title: String {
        switch event.type {
        case .today:
            return "\(event.day + 1)일"
        case .hundred:
            return "\(event.day)일"
        case .year:
            return "\(event.day / 365)주년"
        }
    }
    
    var count: Int {
        return Calendar.countDaysFromNow(fromDate: self.date)
    }
    
    var countTitle: String {
        return count == 0 ? "오늘" : count > 0 ? "" : "D\(count)"
    }
    
    private var date: Date {
        switch event.type {
        case .today:
            return Date()
        case .hundred:
            return calendar.date(byAdding: .day, value: event.day - 1, to: firstDayDate) ?? Date()
        case .year:
            return calendar.date(byAdding: .year, value: event.day / 365, to: firstDayDate) ?? Date()
        }
    }
    
    var dateTitle: String {
        return date.toStringWithDayOfTheWeek()
    }
    
}
