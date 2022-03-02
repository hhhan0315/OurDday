//
//  CalendarController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class CalendarController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var calendarTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FSCalendarCell.self, forCellReuseIdentifier: FSCalendarCell.identifier)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private lazy var todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CalendarTodoCell.self, forCellReuseIdentifier: CalendarTodoCell.identifier)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        return tableView
    }()
    
    private var calendarDate = Date()
    private var selectCalendarEvents = [CalendarEvent]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        updateSelectedCalendarEvents()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "달력"
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchAddButton(_:)))
        
        view.addSubview(calendarTableView)
        view.addSubview(todoTableView)
        
        calendarTableView.translatesAutoresizingMaskIntoConstraints = false
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2),
            
            todoTableView.topAnchor.constraint(equalTo: calendarTableView.bottomAnchor),
            todoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func updateSelectedCalendarEvents() {
        selectCalendarEvents = RealmManager.shared.readCalendarEvent().filter {$0.dateString == calendarDate.toCalendarDateString()}
        calendarTableView.reloadData()
        todoTableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func touchAddButton(_ sender: UIBarButtonItem) {
        let calendarAddController = CalendarAddController()
        calendarAddController.calendarDate = self.calendarDate
        calendarAddController.delegate = self
        let nav = CalendarController.configureTemplateNavigationController(rootViewController: calendarAddController)
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CalendarController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == calendarTableView {
            return 1
        } else {
            return selectCalendarEvents.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == calendarTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FSCalendarCell.identifier, for: indexPath) as? FSCalendarCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.delegate = self

            return cell
        } else if tableView == todoTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTodoCell.identifier, for: indexPath) as? CalendarTodoCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.titleLabel.text = selectCalendarEvents[indexPath.row].title

            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if tableView == todoTableView {
//            if editingStyle == .delete {
//                let event = selectCalendarEvents[indexPath.row]
//                print(event)
//            }
//        }
//
//    }
}

// MARK: - UITableViewDelegate

extension CalendarController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == calendarTableView {
            return view.frame.height * 1/2 - 60
        } else if tableView == todoTableView {
            return 64.0
        } else {
            return 0
        }
    }
}

// MARK: - CalendarAddControllerDelegate

extension CalendarController: CalendarAddControllerDelegate {
    func calendarAddControllerDidSave(_ controller: CalendarAddController, _ calendarEvent: CalendarEvent) {
        RealmManager.shared.insert(calendarEvent: calendarEvent)
        updateSelectedCalendarEvents()
        controller.dismiss(animated: true, completion: nil)
    }
    
    func calendarAddControllerDidCancel(_ controller: CalendarAddController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - FSCalendarCellDelegate

extension CalendarController: FSCalendarCellDelegate {
    func fsCalendarChoose(_ date: Date) {
        calendarDate = date
        updateSelectedCalendarEvents()
    }
}
