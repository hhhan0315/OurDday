//
//  FirstLaunchController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/11.
//

import UIKit
import RealmSwift

final class FirstLaunchController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 처음 만난 날"
        return label
    }()
    
    private let dateButton: UIButton = {        
        let button = UIButton(type: .system)
        button.setTitle(Date().toButtonStringKST(), for: .normal)
        button.addTarget(self, action: #selector(touchUpDateButton(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        let realm = try! Realm()
        
        let firstDay = FirstDay()
        firstDay.key = "firstDay"
        firstDay.date = Date()
        
        try! realm.write({
            realm.add(firstDay)
        })
    }

    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "우리만의 디데이"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(touchUpOkButton(_:)))
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
        ])
        
        view.addSubview(dateButton)
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dateButton.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc func touchUpOkButton(_ sender: UIBarButtonItem) {
        print("확인")
    }
    
    @objc func touchUpDateButton(_ sender: UIButton) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.locale = Locale(identifier: "ko_KR")
//        datePicker.setDate(firstDate, animated: true)
        
        let contentView = UIViewController()
        contentView.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.view.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: contentView.view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: contentView.view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentView.view.bottomAnchor),
        ])
        contentView.preferredContentSize.height = 300
        
        let dateChooseActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        dateChooseActionSheet.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.dateButton.setTitle(datePicker.date.toButtonStringKST(), for: .normal)
        }))
        dateChooseActionSheet.setValue(contentView, forKey: "contentViewController")
        dateChooseActionSheet.view.tintColor = .black
        
        present(dateChooseActionSheet, animated: true, completion: nil)
    }
}
