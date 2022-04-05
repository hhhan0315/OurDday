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
        return calendarView
    }()
    
    private lazy var todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CalendarTodoCell.self, forCellReuseIdentifier: CalendarTodoCell.identifier)
        tableView.separatorInset.left = .zero
        tableView.rowHeight = 64
        tableView.backgroundColor = UIColor.backgroundColor
        tableView.separatorColor = UIColor.backgroundColor
        return tableView
    }()
    
    private let viewModel = CalendarViewModel()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNotification()
        
        viewModel.updateSelectDate(date: Date())
        viewModel.updateCalendarEvents()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "달력"
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(touchEditButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchAddButton(_:)))
        
        view.addSubview(calendarView)
        view.addSubview(todoTableView)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            todoTableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            todoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationColorChange), name: Notification.Name.colorChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationTimeChange), name: UIApplication.significantTimeChangeNotification, object: nil)
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
        let calendarEventStruct = CalendarEventStruct(date: viewModel.calendarSelectDate())
        
        let todoAddController = TodoAddController()
        todoAddController.calendarEventStruct = calendarEventStruct
        todoAddController.delegate = self

        let nav = CalendarController.configureTemplateNavigationController(rootViewController: todoAddController)
        present(nav, animated: true, completion: nil)
    }
    
    @objc func handleNotificationColorChange() {
        navigationController?.navigationBar.tintColor = LocalStorage().colorForKey()
    }
    
    @objc func handleNotificationTimeChange() {
        calendarView.reload()
        viewModel.updateSelectDate(date: Date())
        viewModel.updateCalendarEvents()
        todoTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CalendarController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.calendarNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.calendarTitleHeaderInSection()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.calendarEventsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTodoCell.identifier, for: indexPath) as? CalendarTodoCell else {
            return UITableViewCell()
        }
        
        let calendarEvent = viewModel.calendarEvent(at: indexPath.row)
                
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = calendarEvent.title
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = calendarEvent.title
            cell.textLabel?.numberOfLines = 0
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let calendarEvent = viewModel.calendarEvent(at: indexPath.row)
            
            let alert = UIAlertController(title: "일정 삭제", message: "\(calendarEvent.title) 삭제하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                RealmManager.shared.delete(calendarEvent: calendarEvent)
                self.viewModel.updateCalendarEvents()
                self.calendarView.reload()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let calendarEvent = viewModel.calendarEvent(at: indexPath.row)
        let calendarEventstruct = CalendarEventStruct(calendarEvent: calendarEvent)
        
        let todoController = TodoController()
        todoController.calendarEventStruct = calendarEventstruct
        todoController.delegate = self
        navigationController?.pushViewController(todoController, animated: true)
    }
}

// MARK: - TodoAddControllerDelegate

extension CalendarController: TodoAddControllerDelegate {
    func todoAddControllerDidSave(_ controller: TodoAddController, _ calendarEventStruct: CalendarEventStruct) {
        let calendarEvent = CalendarEvent(calendarEventStruct: calendarEventStruct)

        RealmManager.shared.insert(calendarEvent: calendarEvent)

        viewModel.updateCalendarEvents()
        calendarView.reload()
        todoTableView.reloadData()
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func todoAddControllerDidCancel(_ controller: TodoAddController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - FSCalendarViewDelegate

extension CalendarController: FSCalendarViewDelegate {
    func fsCalendarChoose(_ date: Date) {
        viewModel.updateSelectDate(date: date)
        viewModel.updateCalendarEvents()
        todoTableView.reloadData()
    }
}

// MARK: - TodoControllerDelegate

extension CalendarController: TodoControllerDelegate {
    func todoControllerDidTrash(_ controller: TodoController, _ calendarEventStruct: CalendarEventStruct) {
        let calendarEvent = CalendarEvent(calendarEventStruct: calendarEventStruct)

        RealmManager.shared.delete(calendarEvent: calendarEvent)
        viewModel.updateCalendarEvents()
        calendarView.reload()
        todoTableView.reloadData()
        controller.navigationController?.popViewController(animated: true)
    }
    
    func todoControllerDidBack(_ controller: TodoController) {
        viewModel.updateCalendarEvents()
        calendarView.reload()
        todoTableView.reloadData()
    }
}
