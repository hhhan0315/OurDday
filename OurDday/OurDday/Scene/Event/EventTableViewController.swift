//
//  EventTableViewController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class EventTableViewController: UITableViewController {
    
    // MARK: - Properties
    private let viewModel = EventViewModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        viewModel.updateEvent()
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
                
        let eventCellViewModel = EventCellViewModel(event: event)
        cell.viewModel = eventCellViewModel
        
        cell.selectionStyle = .none
        
        return cell
    }
}
