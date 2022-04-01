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
        viewModel.todayCount = EventManager.shared.getTodayCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkTodayCount()
        
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(checkTodayCount), name: UIScene.willEnterForegroundNotification, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(checkTodayCount), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "기념일"
        
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.separatorInset.right = tableView.separatorInset.left
    }
    
    // MARK: - Actions
    
    @objc func checkTodayCount() {
        let newTodayCount = EventManager.shared.getTodayCount()
        
        if viewModel.todayCount != newTodayCount {
            viewModel.todayCount = newTodayCount
            tableView.reloadData()
        }
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
