//
//  EventViewController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit
import Combine

final class EventViewController: UIViewController {
    // MARK: - View Define
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.separatorInset.left = 32
        tableView.separatorInset.right = 32
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Properties
    private let viewModel = EventViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupBind()
        setupNotification()
        
        viewModel.fetch()
    }
    
    // MARK: - Layout
    private func setupViews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    // MARK: - Method
    private func scrollToTodayEvent() {
        guard let index = viewModel.todayEventIndex() else {
            return
        }
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

// MARK: - UITableViewDataSource
extension EventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.eventsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
            return .init()
        }
        
        let event = viewModel.event(at: indexPath.row)
        
        cell.configureCell(with: event)
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension EventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 9
    }
}
