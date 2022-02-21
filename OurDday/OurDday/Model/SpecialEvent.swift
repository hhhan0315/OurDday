//
//  SpecialEvent.swift
//  OurDday
//
//  Created by rae on 2022/02/17.
//

import Foundation

// 이것도 enum으로 구분??

// 100일, 1주년 기념일 모델
struct SpecialEvent {
    var title: String
    var afterDay: Int
    var isPass: Bool = false
    
    // 기념일 100일 = 오늘부터 1일이니까 99일 뒤
    init(afterDay: Int) {
        self.title = afterDay % 365 == 0 ? "\(afterDay / 365)주년" : "\(afterDay)일"
        self.afterDay = afterDay % 365 == 0 ? afterDay : afterDay - 1
    }
    
    func dayCount() -> Int {
        let calendar = Calendar.current
        let from: Date
        
        if self.afterDay % 365 == 0 {
            from = calendar.startOfDay(for: yearDate())
        } else {
            from = calendar.startOfDay(for: specialDate())
        }
        let to = calendar.startOfDay(for: Date())
    
        let components = calendar.dateComponents([.day], from: from, to: to)
        return components.day ?? 0
    }
    
    func configureDateTitle() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd(EEE)"
        formatter.locale = Locale(identifier: "ko_kr")
        if self.afterDay % 365 == 0 {
            return formatter.string(from: yearDate())
        } else {
            return formatter.string(from: specialDate())
        }
    }
    
    private func specialDate() -> Date {
        let firstDayDate = RealmManager.shared.readFirstDayDate()
        return Calendar.current.date(byAdding: .day, value: afterDay, to: firstDayDate) ?? Date()
    }
    
    private func yearDate() -> Date {
        let firstDayDate = RealmManager.shared.readFirstDayDate()
        return Calendar.current.date(byAdding: .year, value: afterDay / 365, to: firstDayDate) ?? Date()
    }
}
