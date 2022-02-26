//
//  CalendarEvent.swift
//  OurDday
//
//  Created by rae on 2022/02/24.
//

import Foundation
import RealmSwift

class CalendarEvent: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
}
