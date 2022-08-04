//
//  DatePickerController.swift
//  OurDday
//
//  Created by rae on 2022/03/31.
//

import UIKit

final class DatePickerController: UIViewController {
        
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_kr")
        datePicker.setDate(LocalStorageManager.shared.readFirstDate(), animated: false)
        datePicker.preferredDatePickerStyle = .wheels
        
        let hundred: TimeInterval = -60 * 60 * 24 * 365 * 100
        datePicker.minimumDate = Date(timeIntervalSinceNow: hundred)
        datePicker.maximumDate = Date()
        
        return datePicker
    }()
    
//    deinit {
//        LocalStorageManager.shared.setDate(date: datePicker.date)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(datePicker)
        preferredContentSize.height = view.frame.height / 3
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
