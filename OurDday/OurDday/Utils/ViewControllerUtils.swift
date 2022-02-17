//
//  ViewControllerUtils.swift
//  OurDday
//
//  Created by rae on 2022/02/17.
//

import UIKit

extension UIViewController {
    func configureDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.locale = Locale(identifier: "ko_KR")
        
        guard let firstDay = RealmManager.shared.readFirstDay() else { return datePicker }
        datePicker.setDate(firstDay.date, animated: false)
        return datePicker
    }
}
