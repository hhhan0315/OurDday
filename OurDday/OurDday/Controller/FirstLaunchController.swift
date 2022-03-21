//
//  FirstLaunchController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/11.
//

import UIKit

final class FirstLaunchController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 처음 만난 날"
        label.font = UIFont.customFontSize(.bigBold)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜를 선택해주세요"
        label.font = UIFont.customFontSize(.middleSystem)
        label.textColor = UIColor.darkGrayColor
        return label
    }()
    
    private let dateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Date().toButtonStringKST(), for: .normal)
        button.addTarget(self, action: #selector(touchUpDateButton(_:)), for: .touchUpInside)
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        return button
    }()
    
    private let storage = LocalStorage()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureFirstDay()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = UIColor.backgroundColor
        
        navigationItem.title = "우리만의 디데이"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.mainColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(touchUpOkButton(_:)))
        
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(dateButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -125),
            
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            dateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            dateButton.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func configureFirstDay() {
        RealmManager.shared.insert(firstDay: FirstDay())
    }
    
    // MARK: - Actions
    
    @objc func touchUpOkButton(_ sender: UIBarButtonItem) {
        storage.setFirstTime()
        view.window?.rootViewController = MainTabController()
    }
    
    @objc func touchUpDateButton(_ sender: UIButton) {
        let datePicker = CustomDatePicker()
        
        let contentView = UIViewController()
        contentView.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.view.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: contentView.view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: contentView.view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentView.view.bottomAnchor),
        ])

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            RealmManager.shared.update(date: datePicker.date) { check in
                if check {
                    LocalStorage().setFirstDate(date: datePicker.date)
                    self.dateButton.setTitle(datePicker.date.toButtonStringKST(), for: .normal)
                }
            }
            
        }))
        alert.setValue(contentView, forKey: "contentViewController")
        
        present(alert, animated: true, completion: nil)
    }
}
