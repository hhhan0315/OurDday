//
//  FirstLaunchController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/11.
//

import UIKit

final class FirstLaunchController: UIViewController {
    // MARK: - UI Define
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 처음 만난 날"
        label.font = UIFont.customFont(.largeTitle)
        return label
    }()
    
    private lazy var dateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(DateFormatter().toTodayYearMonthDay(date: Date()), for: .normal)
        button.titleLabel?.font = UIFont.customFont(.largeTitle)
        button.setTitleColor(UIColor.systemBackground, for: .normal)
        button.addTarget(self, action: #selector(touchDateButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = UIFont.customFont(.largeTitle)
        button.setTitleColor(UIColor.secondarySystemBackground, for: .normal)
        button.addTarget(self, action: #selector(touchStartButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private let localStorageManager = LocalStorageManager.shared

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainColor
        
        setupViews()
//        saveFirstDay()
    }

    // MARK: - Layout
    private func setupViews() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        [titleLabel, dateButton, startButton].forEach {
            view.addSubview($0)
        }
    }
    private func makeConstraints() {
        [titleLabel, dateButton, startButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),

            dateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
        ])
    }
    
    private func saveFirstDay() {
//        localStorage.setFirstDate(date: Date())
    }
    
    // MARK: - Objc
    @objc private func touchStartButton(_ sender: UIBarButtonItem) {
//        localStorageManager.setFirstTime()
        view.window?.rootViewController = HomeController()
    }
    
    @objc private func touchDateButton(_ sender: UIButton) {
        let datePickerController = DatePickerController()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.dateButton.setTitle(DateFormatter().toTodayYearMonthDay(date: datePickerController.datePicker.date), for: .normal)
        }))
        alert.setValue(datePickerController, forKey: "contentViewController")
        
        present(alert, animated: true, completion: nil)
    }
}
