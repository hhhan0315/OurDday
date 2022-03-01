//
//  SettingsDayController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/10.
//

import UIKit

protocol SettingsDayControllerDelegate: AnyObject {
    func settingsDayControllerDidSave(_ controller: SettingsDayController, _ date: Date)
    func settingsDayControllerDidCancel(_ controller: SettingsDayController)
}

final class SettingsDayController: UIViewController {

    // MARK: - Properties
    
    private let datePicker = CustomDatePicker()
    
    weak var delegate: SettingsDayControllerDelegate?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "기념일 설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchCancelButton(_:)))
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
    
    @objc func touchCancelButton(_ sender: UIBarButtonItem) {
        delegate?.settingsDayControllerDidCancel(self)
    }
    
    @objc func touchOkButton(_ sender: UIBarButtonItem) {
        delegate?.settingsDayControllerDidSave(self, datePicker.date)
    }
}
