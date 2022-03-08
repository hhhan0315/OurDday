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
        let newId = "\(Date().timeIntervalSince1970)"
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
    
    func selectById(calendarEventId: String) -> CalendarEvent? {
        return realm.objects(CalendarEvent.self).filter {$0.id == calendarEventId}.first
    }
    
    func delete(calendarEvent: CalendarEvent) {
        try! realm.write {
            if let entity = selectById(calendarEventId: calendarEvent.id) {
                realm.delete(entity)
            }
        }
    }
    
    func update(date: Date, completion: @escaping(Bool) -> Void) {
        if let firstDay = realm.objects(FirstDay.self).first {
            do {
                try realm.write {
                    firstDay.date = date
                    completion(true)
                }
            } catch {
                completion(false)
            }
        }
    }
    
    func update(calendarEvent: CalendarEvent, completion: @escaping(Bool) -> Void) {
        do {
            try realm.write({
                realm.add(calendarEvent, update: .modified)
                completion(true)
            })
        } catch {
            completion(false)
        }
    }
    
    func readFirstDayDate() -> Date {
        return realm.objects(FirstDay.self).first?.date ?? Date()
    }
    
    func readCalendarEvent() -> [CalendarEvent] {
        return Array(realm.objects(CalendarEvent.self))
    }
}
