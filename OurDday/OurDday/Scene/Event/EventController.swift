//
//  EventController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class EventController: UITableViewController {
    
    // MARK: - Properties
        
    private let viewModel = EventViewModel()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNotification()
        viewModel.updateEvent()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "기념일"
        
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.separatorInset.right = tableView.separatorInset.left
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationColorChange), name: Notification.Name.colorChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationTimeChange), name: UIApplication.significantTimeChangeNotification, object: nil)
    }
    
    // MARK: - Actions

    @objc func handleNotificationColorChange() {
        tableView.reloadData()
    }
    
    @objc func handleNotificationTimeChange() {
        viewModel.updateEvent()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension EventController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.eventsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
            return UITableViewCell()
        }
        
        let event = viewModel.event(at: indexPath.row)
                
        let eventCellViewModel = EventCellViewModel(event: event)
        cell.viewModel = eventCellViewModel
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension EventController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
}
