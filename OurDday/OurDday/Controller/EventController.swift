//
//  EventController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class EventController: UITableViewController {
    
    // MARK: - Properties
    
    private var events = [Event]()
    
    private var firstDayDate: Date!

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
        
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.rowHeight = 80
        tableView.separatorInset.right = tableView.separatorInset.left
    }
    
    private func configureEvents() {
        firstDayDate = RealmManager.shared.readFirstDayDate()
        
        events.removeAll()
        
        let ten = Event(type: .hundred, day: 10)
        let fifty = Event(type: .hundred, day: 50)
        
        events.append(contentsOf: [ten, fifty])
        
        for day in stride(from: 100, through: 10000, by: 100) {
            let event = Event(type: .hundred, day: day)
            events.append(event)
        }

        for day in stride(from: 365, through: 10000, by: 365) {
            let event = Event(type: .year, day: day)
            events.append(event)
        }
        
        let today = Event(type: .today, day: Calendar.countDaysFromNow(fromDate: firstDayDate))
        let checkToday = events.contains { $0.day == today.day + 1 }
        
        if !checkToday {
            events.append(today)
        }

        events.sort {$0.day < $1.day}
    }

}

// MARK: - UITableViewDataSource

extension EventController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
            return UITableViewCell()
        }
        
        let event = events[indexPath.row]
                
        let eventCellViewModel = EventCellViewModel(event: event, firstDayDate: firstDayDate)
        cell.viewModel = eventCellViewModel
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - TabBarReselctHandling

extension EventController: TabBarReselctHandling {
    func handleReselect() {
        tableView.setContentOffset(CGPoint(x: 0, y: -88.0), animated: true)
    }
}
