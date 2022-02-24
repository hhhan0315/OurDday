//
//  CalendarController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit
import FSCalendar

final class CalendarController: UIViewController {
    
    // MARK: - Properties

    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.locale = Locale(identifier: "ko_kr")
        calendar.scrollDirection = .vertical
        calendar.appearance.headerDateFormat = "yyyy.MM"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = .darkGray
        calendar.appearance.titleWeekendColor = .red
        calendar.appearance.todayColor = .customColor(.mainColor)
        calendar.appearance.selectionColor = .darkGray
        return calendar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
//        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset.right = tableView.separatorInset.left
        tableView.rowHeight = 60
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
        
        view.addSubview(calendar)
        view.addSubview(tableView)
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2),
            
            tableView.topAnchor.constraint(equalTo: calendar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: calendar.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: calendar.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc func touchAddButton(_ sender: UIBarButtonItem) {
        let calendarAddController = CalendarAddController()
        calendarAddController.chooseDate = calendar.selectedDate ?? calendar.today
        calendarAddController.delegate = self
        let nav = CalendarController.configureTemplateNavigationController(rootViewController: calendarAddController)
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CalendarController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else {
            return UITableViewCell()
        }
                
        return cell
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

extension CalendarController: FSCalendarDelegate, FSCalendarDataSource {
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        <#code#>
//    }
    
}


