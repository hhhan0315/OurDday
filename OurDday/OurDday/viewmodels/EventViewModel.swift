//
//  EventViewModel.swift
//  OurDday
//
//  Created by rae on 2022/02/26.
//

import Foundation

class EventViewModel: NSObject {
    
    private var events = [Event]()
    
    var todayCount: Int? {
        didSet {
            update()
        }
    }
    
    private func update() {
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
}
