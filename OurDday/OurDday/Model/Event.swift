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
    let type: EventType
    let day: Int
}
