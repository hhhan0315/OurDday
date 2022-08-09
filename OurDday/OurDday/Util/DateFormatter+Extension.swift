//
//  DateFormatter+Extension.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/14.
//

import Foundation

extension DateFormatter {
    func toYearMonthDay(date: Date) -> String {
        self.dateFormat = "yyyy.MM.dd"
        self.locale = Locale(identifier: "ko_KR")
        return self.string(from: date)
    }
    
    func toYearMonthDayWeek(date: Date) -> String {
        self.dateFormat = "yyyy.MM.dd(EEE)"
        self.locale = Locale(identifier: "ko_kr")
        return self.string(from: date)
    }
}
