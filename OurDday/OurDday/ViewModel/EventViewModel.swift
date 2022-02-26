//
//  EventViewModel.swift
//  OurDday
//
//  Created by rae on 2022/02/26.
//

import Foundation

class EventViewModel {
    private var events = [Event]()
    
    func update() {
        self.events = EventManager.shared.getEvents()
    }
    
    func eventsCount() -> Int {
        return events.count
    }

    func event(at index: Int) -> Event {
        return events[index]
    }
}
