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
    private let localStorage = LocalStorage()

    // MARK: - Life cycle
    
    override func loadView() {
        view = firstLaunchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNav()
        saveFirstDay()
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
    
    private func saveFirstDay() {
        localStorage.setFirstDate(date: Date())
    }
    
    private func setupAddTarget() {
        firstLaunchView.dateButton.addTarget(self, action: #selector(touchUpDateButton(_:)), for: .touchUpInside)
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
            self.firstLaunchView.dateButton.setTitle(contentController.datePicker.date.toButtonStringKST(), for: .normal)
        }))
        alert.setValue(contentController, forKey: "contentViewController")
        
        present(alert, animated: true, completion: nil)
    }
}
