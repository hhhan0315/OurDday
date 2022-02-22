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
        label.textColor = UIColor.customColor(.mainColor)
        label.font = UIFont.customFontSize(.bigBold)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.customFontSize(.middleSystem)
        return label
    }()

    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let saveDate = RealmManager.shared.readFirstDayDate()
        
        countLabel.text = "\(abs(Calendar.countDaysFromNow(fromDate: saveDate)) + 1)일"
        dateLabel.text = saveDate.toButtonStringKST()
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
    
}
