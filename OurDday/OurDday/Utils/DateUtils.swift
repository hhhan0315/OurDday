//
//  DateUtils.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/14.
//

import Foundation

extension Date {
    func toButtonStringKST() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        return dateFormatter.string(from: self)
    }
}
