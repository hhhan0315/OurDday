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
    var calendarDate = Date()
    
    private lazy var addTextFieldView: AddTextFieldView = {
        let view = AddTextFieldView()
        view.delegate = self
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    private let addDatePickerView: AddDatePickerView = {
        let view = AddDatePickerView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        addDatePickerView.configure(date: calendarDate)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        
        navigationItem.title = "새로운 일정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchCancelButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(touchAddButton(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(addTextFieldView)
        view.addSubview(addDatePickerView)
        
        addTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        addDatePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addTextFieldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            addTextFieldView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            addTextFieldView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            addTextFieldView.heightAnchor.constraint(equalToConstant: 64.0),
            
            addDatePickerView.topAnchor.constraint(equalTo: addTextFieldView.bottomAnchor, constant: 20.0),
            addDatePickerView.leadingAnchor.constraint(equalTo: addTextFieldView.leadingAnchor),
            addDatePickerView.trailingAnchor.constraint(equalTo: addTextFieldView.trailingAnchor),
            addDatePickerView.heightAnchor.constraint(equalToConstant: 250.0),
        ])
    }
    
    // MARK: - Actions
        
    @objc func touchCancelButton(_ sender: UIBarButtonItem) {
        delegate?.calendarAddControllerDidCancel(self)
    }
    
    @objc func touchAddButton(_ sender: UIBarButtonItem) {
        let calendarEvent = CalendarEvent()
        calendarEvent.title = titleText
        calendarEvent.dateString = calendarDate.toCalendarDateString()
        
        delegate?.calendarAddControllerDidSave(self, calendarEvent)
    }

}

// MARK: - AddTextFieldCellDelegate

extension CalendarAddController: AddTextFieldCellDelegate {
    func addTextFieldChange(_ text: String) {
        navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
        titleText = text
    }
}
