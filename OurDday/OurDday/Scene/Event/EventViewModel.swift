//
//  EventViewModel.swift
//  OurDday
//
//  Created by rae on 2022/02/26.
//

import Foundation

class EventViewModel: NSObject {
    
    @Published var events = [Event]()
    
    func fetch() {
        events.removeAll()
        EventManager.shared.getEvents(completion: { events in
            self.events = events
        })
    }
    
    func eventsCount() -> Int {
        return events.count
    }

    func event(at index: Int) -> Event {
        return events[index]
    }
    
    func todayEventIndex() -> Int? {
        let index = events.firstIndex { $0.type == .today }
        return index
    }
}
