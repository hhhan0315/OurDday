//
//  EventManager.swift
//  OurDday
//
//  Created by rae on 2022/02/26.
//

import Foundation

final class EventManager {
    static let shared = EventManager()
    
    func getTodayCount() -> Int {
        let firstDayDate = LocalStorage().readFirstDate()
        let todayCount = Calendar.countDaysFromNow(fromDate: firstDayDate)
        return todayCount
    }
    
    func getEvents(completion: @escaping([Event]) -> Void) {
        var events = [Event]()
        let firstDayDate = LocalStorage().readFirstDate()
        
        let ten = Event(type: .hundred, day: 10)
        let fifty = Event(type: .hundred, day: 50)
        
        events.append(contentsOf: [ten, fifty])
        
        for day in stride(from: 100, through: 10000, by: 100) {
            let event = Event(type: .hundred, day: day)
            events.append(event)
        }

        for day in stride(from: 365, through: 10000, by: 365) {
            let event = Event(type: .year, day: day)
            events.append(event)
        }
        
        let today = Event(type: .today, day: Calendar.countDaysFromNow(fromDate: firstDayDate))
        let checkToday = events.contains { $0.day == today.day + 1 }
        
        if !checkToday {
            events.append(today)
        }

        events.sort {$0.day < $1.day}
        
        completion(events)
    }
}
