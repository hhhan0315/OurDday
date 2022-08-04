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
        button.setTitleColor(UIColor.sampleMainColor, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    private let localStorage = LocalStorage()

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNav()
        saveFirstDay()
        setupAddTarget()
    }

    // MARK: - Layout
    private func setupViews() {
        
    }
    
    private func addSubviews() {
        [titleLabel, infoLabel, dateButton].forEach {
            view.addSubview($0)
        }
    }
    private func configureUI() {
        [titleLabel, infoLabel, dateButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -125),
//
//            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
//
//            dateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            dateButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
//            dateButton.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
    private func configureNav() {
        navigationItem.title = "우리만의 디데이"
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(touchUpOkButton(_:)))
    }
    
    private func saveFirstDay() {
        localStorage.setFirstDate(date: Date())
    }
    
    private func setupAddTarget() {
        dateButton.addTarget(self, action: #selector(touchUpDateButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func touchUpOkButton(_ sender: UIBarButtonItem) {
        localStorage.setFirstTime()
        localStorage.setPhrases(phrases: "우리 디데이")
        view.window?.rootViewController = MainTabController()
    }
    
    @objc func touchUpDateButton(_ sender: UIButton) {
        let contentController = ContentDatePickerController()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.localStorage.setFirstDate(date: contentController.datePicker.date)
            self.dateButton.setTitle(contentController.datePicker.date.toButtonStringKST(), for: .normal)
        }))
        alert.setValue(contentController, forKey: "contentViewController")
        
        present(alert, animated: true, completion: nil)
    }
}
