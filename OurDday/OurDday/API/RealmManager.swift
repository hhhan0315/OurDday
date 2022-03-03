//
//  RealmManager.swift
//  OurDday
//
//  Created by rae on 2022/02/17.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    
    private var realm: Realm
    
    private init() {
        realm = try! Realm()
    }
    
    func insert(firstDay: FirstDay) {
        deleteAll()
        try! realm.write({
            realm.add(firstDay)
        })
        
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func insert(calendarEvent: CalendarEvent) {
        let newId = Date().timeIntervalSince1970
        calendarEvent.id = newId
        try! realm.write({
            realm.add(calendarEvent)
        })        
    }
    
    private func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func delete(calendarEvent: CalendarEvent) {
        try! realm.write {
            realm.delete(calendarEvent)
        }
    }
    
    func update(date: Date) {
        if let firstDay = realm.objects(FirstDay.self).first {
            try! realm.write({
                firstDay.date = date
            })
        }
    }
    
    func readFirstDayDate() -> Date {
        return realm.objects(FirstDay.self).first?.date ?? Date()
    }
    
    func readCalendarEvent() -> [CalendarEvent] {
        return Array(realm.objects(CalendarEvent.self))
    }
}
