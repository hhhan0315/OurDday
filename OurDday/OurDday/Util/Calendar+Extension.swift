//
//  Calendar+Extension.swift
//  OurDday
//
//  Created by rae on 2022/02/22.
//

import Foundation

extension Calendar {
    static func countDaysFromNow(fromDate: Date) -> Int {
        let calendar = Calendar.current
        
        let from = calendar.startOfDay(for: fromDate)
        let to = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: from, to: to)
        let dayCount = components.day ?? 0
        
        return dayCount
    }
}
