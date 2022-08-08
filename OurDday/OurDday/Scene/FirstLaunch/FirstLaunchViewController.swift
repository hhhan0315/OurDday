//
//  FirstLaunchViewController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/11.
//

import UIKit

final class FirstLaunchViewController: UIViewController {
    // MARK: - UI Define
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 처음 만난 날"
        label.font = UIFont.customFont(.largeTitle)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var dateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(DateFormatter().toYearMonthDay(date: Date()), for: .normal)
        button.titleLabel?.font = UIFont.customFont(.largeTitle)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(touchDateButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = UIFont.customFont(.largeTitle)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(touchStartButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private var selectDate: Date = Date()

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainColor
        
        setupViews()
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
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
        ])
    }
    
    // MARK: - Objc
    @objc private func touchStartButton(_ sender: UIButton) {
        LocalStorageManager.shared.setFirstLaunch()
        LocalStorageManager.shared.setDate(date: selectDate)
        view.window?.rootViewController = TabViewController()
    }
    
    @objc private func touchDateButton(_ sender: UIButton) {
        let datePickerController = DatePickerViewController()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            let datePickerDate = datePickerController.datePicker.date
            self.selectDate = datePickerDate
            self.dateButton.setTitle(DateFormatter().toYearMonthDay(date: datePickerDate), for: .normal)
        }))
        alert.setValue(datePickerController, forKey: "contentViewController")
        
        present(alert, animated: true, completion: nil)
    }
}
