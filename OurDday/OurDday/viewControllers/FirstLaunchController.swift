//
//  FirstLaunchController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/11.
//

import UIKit

final class FirstLaunchController: UIViewController {
    
    // MARK: - Properties
    
    private let firstLaunchView = FirstLaunchView()

    // MARK: - Life cycle
    
    override func loadView() {
        view = firstLaunchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNav()
        configureFirstDay()
        setupAddTarget()
    }

    // MARK: - Helpers
    
    private func configureNav() {
        navigationItem.title = "우리만의 디데이"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.mainColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(touchUpOkButton(_:)))
    }
    
    private func configureFirstDay() {
        RealmManager.shared.insert(firstDay: FirstDay())
    }
    
    private func setupAddTarget() {
        firstLaunchView.dateButton.addTarget(self, action: #selector(touchUpDateButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func touchUpOkButton(_ sender: UIBarButtonItem) {
        LocalStorage().setFirstTime()
        view.window?.rootViewController = MainTabController()
    }
    
    @objc func touchUpDateButton(_ sender: UIButton) {
        let contentView = UIViewController()
        let datePicker = CustomDatePicker()
        contentView.view.addSubview(datePicker)
        contentView.preferredContentSize.height = view.frame.height / 3
        
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
                    self.firstLaunchView.dateButton.setTitle(datePicker.date.toButtonStringKST(), for: .normal)
                }
            }
        }))
        alert.setValue(contentView, forKey: "contentViewController")
        
        present(alert, animated: true, completion: nil)
    }
}
