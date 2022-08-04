//
//  DateFormatter+Extension.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/14.
//

import Foundation

extension Date {
    func toStringWithDayOfTheWeek() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "yyyy.MM.dd(EEE)"
        return formatter.string(from: self)
    }
}

extension DateFormatter {
    func toTodayYearMonthDay(date: Date) -> String {
        self.dateFormat = "yyyy-MM-dd"
        self.locale = Locale(identifier: "ko_KR")
        return self.string(from: date)
    }
}
