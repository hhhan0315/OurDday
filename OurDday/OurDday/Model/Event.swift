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
}
