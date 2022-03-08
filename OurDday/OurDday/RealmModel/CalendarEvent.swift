//
//  CalendarEvent.swift
//  OurDday
//
//  Created by rae on 2022/02/24.
//

import Foundation
import RealmSwift

class CalendarEvent: Object {
    @objc dynamic var id: String = "\(Date().timeIntervalSince1970)"
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var memo: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
