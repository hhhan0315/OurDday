//
//  ContentDatePickerController.swift
//  OurDday
//
//  Created by rae on 2022/03/31.
//

import UIKit

final class ContentDatePickerController: UIViewController {
    
    let datePicker = CustomDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(datePicker)
        preferredContentSize.height = view.frame.height / 3
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}
