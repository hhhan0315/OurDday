//
//  EventTableViewController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit
import Combine

final class EventTableViewController: UITableViewController {
    
    // MARK: - Properties
    private let viewModel = EventViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBind()
        setupNotification()
        
        viewModel.fetch()
    }
    
    // MARK: - Layout
    private func setupTableView() {
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.separatorInset.left = 32
        tableView.separatorInset.right = 32
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 8
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.eventsCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
            return .init()
        }
        
        let event = viewModel.event(at: indexPath.row)
        
        cell.configureCell(with: event)
        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: - Method
    private func scrollToTodayEvent() {
        guard let index = viewModel.todayEventIndex() else {
            return
        }
        tableView.layoutIfNeeded()
        tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: false)
    }
    
    // MARK: - Bind
    private func setupBind() {
        viewModel.$events
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.tableView.reloadData()
                self.scrollToTodayEvent()
            }
            .store(in: &cancellable)
    }
    
    // MARK: - Notification
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationChangeDate), name: Notification.Name.changeDate, object: nil)
    }
    
    @objc private func notificationChangeDate() {
        viewModel.fetch()
    }
}
