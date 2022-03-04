//
//  CalendarEvent.swift
//  OurDday
//
//  Created by rae on 2022/02/24.
//

import Foundation
import RealmSwift

class CalendarEvent: Object {
    @objc dynamic var id: Double = Date().timeIntervalSince1970
    @objc dynamic var title: String = ""
    @objc dynamic var dateString: String = ""
    @objc dynamic var memo: String = ""
}
