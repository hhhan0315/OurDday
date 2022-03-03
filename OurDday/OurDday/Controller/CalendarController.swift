//
//  CalendarController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class CalendarController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var calendarView: FSCalendarView = {
        let calendarView = FSCalendarView()
        calendarView.delegate = self
        calendarView.layer.cornerRadius = 15
        calendarView.backgroundColor = .white
        return calendarView
    }()
    
    private lazy var todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CalendarTodoCell.self, forCellReuseIdentifier: CalendarTodoCell.identifier)
        tableView.separatorInset.right = tableView.separatorInset.left
        return tableView
    }()
    
    private var calendarDate = Date()
    private var selectCalendarEvents = [CalendarEvent]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        updateSelectedCalendarEvents()
        updateCalendarView()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        
        navigationItem.title = "달력"
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(touchEditButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchAddButton(_:)))
        
        view.addSubview(calendarView)
        view.addSubview(todoTableView)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            calendarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            todoTableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            todoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func updateSelectedCalendarEvents() {
        selectCalendarEvents = RealmManager.shared.readCalendarEvent().filter {$0.dateString == calendarDate.toCalendarDateString()}
        todoTableView.reloadData()
    }
    
    private func updateCalendarView() {
        calendarView.calendarEvents = RealmManager.shared.readCalendarEvent()
    }
    
    // MARK: - Actions
    
    @objc func touchEditButton(_ sender: UIBarButtonItem) {
        if todoTableView.isEditing {
            todoTableView.setEditing(false, animated: true)
            sender.title = "편집"
        } else {
            todoTableView.setEditing(true, animated: true)
            sender.title = "완료"
        }
    }
    
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
        return selectCalendarEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTodoCell.identifier, for: indexPath) as? CalendarTodoCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = selectCalendarEvents[indexPath.row].title
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = selectCalendarEvents[indexPath.row].title
            cell.textLabel?.numberOfLines = 0
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let event = selectCalendarEvents[indexPath.row]
            let alert = UIAlertController(title: "zz", message: "zzz", preferredStyle: .alert)
//            alert.title = "일정 삭제"
//            alert.message = "\(event.title)를 삭제하시겠습니까?"
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                RealmManager.shared.delete(calendarEvent: event)
                self.updateCalendarView()
                self.selectCalendarEvents.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDelegate

extension CalendarController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

// MARK: - CalendarAddControllerDelegate

extension CalendarController: CalendarAddControllerDelegate {
    func calendarAddControllerDidSave(_ controller: CalendarAddController, _ calendarEvent: CalendarEvent) {
        RealmManager.shared.insert(calendarEvent: calendarEvent)
        updateSelectedCalendarEvents()
        updateCalendarView()
        controller.dismiss(animated: true, completion: nil)
    }
    
    func calendarAddControllerDidCancel(_ controller: CalendarAddController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - FSCalendarCellDelegate

extension CalendarController: FSCalendarViewDelegate {
    func fsCalendarChoose(_ date: Date) {
        calendarDate = date
        updateSelectedCalendarEvents()
    }
}
