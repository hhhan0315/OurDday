//
//  CalendarController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class CalendarController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FSCalendarCell.self, forCellReuseIdentifier: FSCalendarCell.identifier)
        tableView.register(CalendarTodoCell.self, forCellReuseIdentifier: CalendarTodoCell.identifier)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "달력"
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchAddButton(_:)))
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc func touchAddButton(_ sender: UIBarButtonItem) {
        let calendarAddController = CalendarAddController()
//        calendarAddController.chooseDate = calendar.selectedDate ?? calendar.today
        calendarAddController.delegate = self
        let nav = CalendarController.configureTemplateNavigationController(rootViewController: calendarAddController)
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CalendarController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FSCalendarCell.identifier, for: indexPath) as? FSCalendarCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none

            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTodoCell.identifier, for: indexPath) as? CalendarTodoCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
}

// MARK: - UITableViewDelegate

extension CalendarController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 400.0
        } else if indexPath.section == 1 {
            return 55.0
        } else {
            return 0
        }
    }
}

// MARK: - CalendarAddControllerDelegate

extension CalendarController: CalendarAddControllerDelegate {
    func calendarAddControllerDidSave(_ controller: CalendarAddController, _ calendarEvent: CalendarEvent) {
        RealmManager.shared.insert(calendarEvent: calendarEvent)
        controller.dismiss(animated: true, completion: nil)
    }
    
    func calendarAddControllerDidCancel(_ controller: CalendarAddController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - FSCalendarDelegate, FSCalendarDataSource

//extension CalendarController: FSCalendarDelegate, FSCalendarDataSource {
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        <#code#>
//    }
    
//}


