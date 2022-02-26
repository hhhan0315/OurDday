//
//  CalendarAddController.swift
//  OurDday
//
//  Created by rae on 2022/02/23.
//

import UIKit

protocol CalendarAddControllerDelegate: AnyObject {
    func calendarAddControllerDidSave(_ controller: CalendarAddController, _ calendarEvent: CalendarEvent)
    func calendarAddControllerDidCancel(_ controller: CalendarAddController)
}

final class CalendarAddController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: CalendarAddControllerDelegate?
    
    var titleText: String = ""
    var chooseDate: Date!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(AddTextFieldCell.self, forCellReuseIdentifier: AddTextFieldCell.identifier)
        tableView.register(AddDatePickerCell.self, forCellReuseIdentifier: AddDatePickerCell.identifier)
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchTableView(_:))))
        return tableView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "새로운 일정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchCancelButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(touchAddButton(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
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
    
    // 여기도 delegate로 수정한 뒤 CalendarController에서 동작하는 걸로??
    
    @objc func touchCancelButton(_ sender: UIBarButtonItem) {
        delegate?.calendarAddControllerDidCancel(self)
    }
    
    @objc func touchAddButton(_ sender: UIBarButtonItem) {
        let calendarEvent = CalendarEvent()
        calendarEvent.title = titleText
        calendarEvent.date = chooseDate
        delegate?.calendarAddControllerDidSave(self, calendarEvent)
    }
    
    @objc func touchTableView(_ sender: UITableView) {
        view.endEditing(true)
    }

}

// MARK: - UITableViewDataSource

extension CalendarAddController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTextFieldCell.identifier, for: indexPath) as? AddTextFieldCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.delegate = self

            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddDatePickerCell.identifier, for: indexPath) as? AddDatePickerCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.configure(date: self.chooseDate)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

// MARK: - UITableViewDelegate

extension CalendarAddController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 55.0
        } else if indexPath.section == 1 {
            return 255.0
        } else {
            return 0
        }
    }
}

// MARK: - AddTextFieldCellDelegate

extension CalendarAddController: AddTextFieldCellDelegate {
    func addTextFieldChange(_ text: String) {
        navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
        titleText = text
    }
}
