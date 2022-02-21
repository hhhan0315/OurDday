//
//  HomeController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appColor(.mainColor)
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkDate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "디데이"
        
        view.addSubview(countLabel)
        view.addSubview(dateLabel)
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
        ])
    }
    
    private func checkDate() {
        let saveDate = RealmManager.shared.readFirstDayDate()
        let calendar = Calendar.current
        
        let from = calendar.startOfDay(for: saveDate)
        let to = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: from, to: to)
        let dayCount = components.day ?? 0
        
        if dayCount >= 0 {
            countLabel.text = "\(abs(dayCount) + 1)일"
            dateLabel.text = saveDate.toButtonStringKST()
        }
    }
}
