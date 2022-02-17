//
//  SettingsDayController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/10.
//

import UIKit

final class SettingsDayController: UIViewController {

    // MARK: - Properties
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "기념일 설정"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(touchOkButton(_:)))
        
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    // MARK: - Actions
    
    @objc func touchOkButton(_ sender: UIBarButtonItem) {
//        let date = DateUtils.makeKoreanDateString(date: datePicker.date)
//        CoreDataManager.shared.insertFirstDay(date: date)
        navigationController?.popViewController(animated: true)
    }
}
