////
////  RealmManager.swift
////  OurDday
////
////  Created by rae on 2022/02/17.
////
//
//import Foundation
//
//final class RealmManager {
//    static let shared = RealmManager()
//    
//    private var realm: Realm
//    
//    private init() {
//        realm = try! Realm()
//        
////        print(Realm.Configuration.defaultConfiguration.fileURL!)
//    }
//    
//    func insert(calendarEvent: CalendarEvent) {
//        let newId = "\(Date().timeIntervalSince1970)"
//        calendarEvent.id = newId
//        
//        do {
//            try realm.write({
//                realm.add(calendarEvent)
//            })
//        } catch {
//            print("\(error)")
//        }
//    }
//    
////    private func deleteAll() {
////        do {
////            try realm.write {
////                realm.deleteAll()
////            }
////        } catch {
////            print("\(error)")
////        }
////    }
//    
//    func selectById(calendarEventId: String) -> CalendarEvent? {
//        return realm.objects(CalendarEvent.self).filter {$0.id == calendarEventId}.first
//    }
//    
//    func delete(calendarEvent: CalendarEvent) {
//        do {
//            try realm.write {
//                if let entity = selectById(calendarEventId: calendarEvent.id) {
//                    realm.delete(entity)
//                }
//            }
//        } catch {
//            print("\(error)")
//        }
//    }
//    
//    func update(calendarEvent: CalendarEvent, completion: @escaping(Bool) -> Void) {
//        do {
//            try realm.write({
//                realm.add(calendarEvent, update: .modified)
//                completion(true)
//            })
//        } catch {
//            completion(false)
//        }
//    }
//    
//    func readCalendarEvent() -> [CalendarEvent] {
//        return Array(realm.objects(CalendarEvent.self))
//    }
//}
