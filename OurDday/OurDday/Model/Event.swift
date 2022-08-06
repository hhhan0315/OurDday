//
//  Event.swift
//  OurDday
//
//  Created by rae on 2022/02/17.
//

import Foundation

struct Event {
    enum EventType {
        case hundred
        case year
        case today
    }
    
    let type: EventType
    let day: Int
    
    var title: String {
        switch type {
        case .today:
            return "\(day + 1)일"
        case .hundred:
            return "\(day)일"
        case .year:
            return "\(day / 365)주년"
        }
    }
    
    private var date: Date {
        let saveDate = LocalStorageManager.shared.readDate()
        switch type {
        case .today:
            return Date()
        case .hundred:
            return Calendar.current.date(byAdding: .day, value: day - 1, to: saveDate) ?? Date()
        case .year:
            return Calendar.current.date(byAdding: .year, value: day / 365, to: saveDate) ?? Date()
        }
    }
    
    var dateTitle: String {
        return DateFormatter().toYearMonthDayWeek(date: date)
    }
    
    var count: Int {
        return Calendar.countDaysFromNow(fromDate: date)
    }
    
    var countTitle: String {
        return count == 0 ? "오늘" : count > 0 ? "" : "D\(count)"
    }
}
