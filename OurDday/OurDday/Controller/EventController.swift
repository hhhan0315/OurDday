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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.update()
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "기념일"
        
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.rowHeight = 80
        tableView.separatorInset.right = tableView.separatorInset.left
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

// MARK: - TabBarReselctHandling

extension EventController: TabBarReselctHandling {
    func handleReselect() {
        tableView.setContentOffset(CGPoint(x: 0, y: -88.0), animated: true)
    }
}