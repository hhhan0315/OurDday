//
//  SpecialDayController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class SpecialDayController: UITableViewController {
    
    // MARK: - Properties
    
    private var specialDays = [SpecialEvent]()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureSpecialEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "기념일"
        
        tableView.register(SpecialDaysCell.self, forCellReuseIdentifier: SpecialDaysCell.identifier)
        tableView.rowHeight = 90
    }
    
    private func configureSpecialEvents() {
        // 10, 50
        let ten = SpecialEvent(afterDay: 10)
        let fifty = SpecialEvent(afterDay: 50)
        specialDays.append(contentsOf: [ten, fifty])
        
        // 100, 200 ... 10000
        for i in stride(from: 100, through: 10000, by: 100) {
            let event = SpecialEvent(afterDay: i)
            specialDays.append(event)
        }
        
        // 1주년, 2주년, 3주년 ...
        for i in stride(from: 365, through: 10000, by: 365) {
            let event = SpecialEvent(afterDay: i)
            specialDays.append(event)
        }
        
        specialDays.sort {$0.afterDay < $1.afterDay}
        
        // 오늘
    }

}

// MARK: - UITableViewDataSource

extension SpecialDayController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialDays.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpecialDaysCell.identifier, for: indexPath) as? SpecialDaysCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let specialDay = specialDays[indexPath.row]
        let dayCount = specialDay.dayCount()
        
        cell.titleLabel.text = specialDay.title
        cell.dateTitleLabel.text = specialDay.configureDateTitle()
        cell.countLabel.text = dayCount == 0 ? "Today" : dayCount > 0 ? "D+\(dayCount)" : "D\(dayCount)"
        
        return cell
    }
}
