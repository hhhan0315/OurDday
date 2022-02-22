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
}

struct Event {
    var type: EventType
    var isPass: Bool = false
    var title: String
    var day: Int
    var date: Date
    
    init(type: EventType, day: Int, firstDayDate: Date) {
        switch type {
        case .hundred:
            self.type = type
            self.title = "\(day)일"
            self.day = day - 1
            self.date = Calendar.current.date(byAdding: .day, value: day - 1, to: firstDayDate) ?? Date()
        case .year:
            self.type = type
            self.title = "\(day / 365)주년"
            self.day = day
            self.date = Calendar.current.date(byAdding: .year, value: day / 365, to: firstDayDate) ?? Date()
        }
    }
    
    func dayCount() -> Int {
        let calendar = Calendar.current
        let from = calendar.startOfDay(for: self.date)
        let to = calendar.startOfDay(for: Date())
    
        let components = calendar.dateComponents([.day], from: from, to: to)
        let day = components.day ?? 0
        
        return day
    }

}
