//
//  Event.swift
//  OurDday
//
//  Created by rae on 2022/02/17.
//

import Foundation

enum EventType {
    case hundred
    case year
    case today
}

struct Event {
    var type: EventType
    var isPass: Bool = false
    var title: String
    var date: Date
    var dayCount: Int
    
    init(type: EventType, day: Int, firstDayDate: Date) {
        switch type {
        case .hundred:
            self.type = type
            self.title = "\(day)일"
            self.date = Calendar.current.date(byAdding: .day, value: day - 1, to: firstDayDate) ?? Date()
        case .year:
            self.type = type
            self.title = "\(day / 365)주년"
            self.date = Calendar.current.date(byAdding: .year, value: day / 365, to: firstDayDate) ?? Date()
        case .today:
            self.type = type
            self.title = "\(abs(Calendar.countDaysFromNow(fromDate: firstDayDate)) + 1)일" 
            self.date = Date()
        }
        self.dayCount = Calendar.countDaysFromNow(fromDate: self.date)
    }
}
