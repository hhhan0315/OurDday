//
//  SettingsDayController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/10.
//

import UIKit

final class SettingsDayController: UIViewController {

    // MARK: - Properties
    
    private let datePicker = CustomDatePicker()
        
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
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50.0),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50.0),
        ])
    }

    // MARK: - Actions
    
    @objc func touchCancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchOkButton(_ sender: UIBarButtonItem) {
        RealmManager.shared.update(date: datePicker.date, completion: { check in
            if check {
                LocalStorage().setFirstDate(date: self.datePicker.date)
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
}
