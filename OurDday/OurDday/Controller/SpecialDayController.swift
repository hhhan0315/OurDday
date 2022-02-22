//
//  SpecialDayController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class SpecialDayController: UITableViewController {
    
    // MARK: - Properties
    
    private var events = [Event]()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "기념일"
        
        tableView.register(SpecialDayCell.self, forCellReuseIdentifier: SpecialDayCell.identifier)
        tableView.rowHeight = 85
        tableView.separatorInset.right = tableView.separatorInset.left
    }
    
    private func configureEvents() {
        let firstDayDate = RealmManager.shared.readFirstDayDate()
        
        let ten = Event(type: .hundred, day: 10, firstDayDate: firstDayDate)
        let fifty = Event(type: .hundred, day: 50, firstDayDate: firstDayDate)
        
        events.append(contentsOf: [ten, fifty])
        
        for day in stride(from: 100, through: 10000, by: 100) {
            let event = Event(type: .hundred, day: day, firstDayDate: firstDayDate)
            events.append(event)
        }
        
        for day in stride(from: 365, through: 10000, by: 365) {
            let event = Event(type: .year, day: day, firstDayDate: firstDayDate)
            events.append(event)
        }
        
        events.sort {$0.day < $1.day}
        
    }

}

// MARK: - UITableViewDataSource

extension SpecialDayController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpecialDayCell.identifier, for: indexPath) as? SpecialDayCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let event = events[indexPath.row]
        let dayCount = event.dayCount()
        
        cell.titleLabel.text = event.title
        cell.countLabel.text = dayCount == 0 ? "Today" : dayCount > 0 ? "" : "D\(dayCount)"
        cell.countLabel.textColor = UIColor.customColor(.mainColor)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd(EEE)"
        formatter.locale = Locale(identifier: "ko_kr")
        cell.dateTitleLabel.text = formatter.string(from: event.date)
        
//        if event.isPass {
//            cell.titleLabel.textColor = .lightGray
//            cell.dateTitleLabel.textColor = .lightGray
//            cell.countLabel.textColor = .lightGray
//        }
        
        return cell
    }
}