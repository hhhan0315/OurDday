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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureEvents()
        tableView.reloadData()        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "기념일"
        
        tableView.register(SpecialDayCell.self, forCellReuseIdentifier: SpecialDayCell.identifier)
        tableView.rowHeight = 80
        tableView.separatorInset.right = tableView.separatorInset.left
    }
    
    private func configureEvents() {
        events.removeAll()
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
        
        let today = Event(type: .today, day: 0, firstDayDate: firstDayDate)
        let eventsHaveToday = events.contains { $0.dayCount == today.dayCount }
        
        if eventsHaveToday == false {
            events.append(today)
        }
        
        events.sort {$0.date < $1.date}
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
        
        let event = events[indexPath.row]
        
        cell.configure(event: event)
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - TabBarReselctHandling

extension SpecialDayController: TabBarReselctHandling {
    func handleReselect() {
        tableView.setContentOffset(CGPoint(x: 0, y: -88.0), animated: true)
    }
}
