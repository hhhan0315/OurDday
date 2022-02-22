//
//  CustomDatePicker.swift
//  OurDday
//
//  Created by rae on 2022/02/21.
//

import UIKit

final class CustomDatePicker: UIDatePicker {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.datePickerMode = .date
        self.locale = Locale(identifier: "ko_kr")
        self.setDate(RealmManager.shared.readFirstDayDate(), animated: false)
        
        if #available(iOS 13.4, *) {
            self.preferredDatePickerStyle = .wheels
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}