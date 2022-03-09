//
//  CalendarAddController.swift
//  OurDday
//
//  Created by rae on 2022/02/23.
//

import UIKit

protocol TodoAddControllerDelegate: AnyObject {
    func todoAddControllerDidSave(_ controller: TodoAddController, _ calendarEvent: CalendarEvent)
    func todoAddControllerDidCancel(_ controller: TodoAddController)
}

final class TodoAddController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: TodoAddControllerDelegate?
    
    var calendarEvent: CalendarEvent? {
        didSet {
            configureCalendarEvent()
        }
    }
    
    private lazy var addTextFieldView: AddTextFieldView = {
        let view = AddTextFieldView()
        view.delegate = self
        view.layer.cornerRadius = CGFloat.customSize(.cornerRadius)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var addDatePickerView: AddDatePickerView = {
        let view = AddDatePickerView()
        view.delegate = self
        view.layer.cornerRadius = CGFloat.customSize(.cornerRadius)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var addTextView: AddTextView = {
        let view = AddTextView()
        view.delegate = self
        view.layer.cornerRadius = CGFloat.customSize(.cornerRadius)
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        
        guard let calendarEvent = calendarEvent else { return }
        
        navigationItem.title = calendarEvent.title.isEmpty ? "새로운 일정" : "일정 수정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchCancelButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: calendarEvent.title.isEmpty ? "추가" : "완료", style: .plain, target: self, action: #selector(touchSaveButton(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = !calendarEvent.title.isEmpty
        
        view.addSubview(addTextFieldView)
        view.addSubview(addDatePickerView)
        view.addSubview(addTextView)
        
        addTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        addDatePickerView.translatesAutoresizingMaskIntoConstraints = false
        addTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let anchorSpace = CGFloat.customSize(.anchorSpace)
        
        NSLayoutConstraint.activate([
            addTextFieldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: anchorSpace),
            addTextFieldView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: anchorSpace),
            addTextFieldView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -anchorSpace),
            addTextFieldView.heightAnchor.constraint(equalToConstant: 44.0),
            
            addDatePickerView.topAnchor.constraint(equalTo: addTextFieldView.bottomAnchor, constant: anchorSpace),
            addDatePickerView.leadingAnchor.constraint(equalTo: addTextFieldView.leadingAnchor),
            addDatePickerView.trailingAnchor.constraint(equalTo: addTextFieldView.trailingAnchor),
            addDatePickerView.heightAnchor.constraint(equalToConstant: 155.0),
            
            addTextView.topAnchor.constraint(equalTo: addDatePickerView.bottomAnchor, constant: anchorSpace),
            addTextView.leadingAnchor.constraint(equalTo: addDatePickerView.leadingAnchor),
            addTextView.trailingAnchor.constraint(equalTo: addDatePickerView.trailingAnchor),
            addTextView.heightAnchor.constraint(equalToConstant: 155.0),
        ])
    }
    
    private func configureCalendarEvent() {
        guard let calendarEvent = calendarEvent else { return }

        addTextFieldView.textFieldText = calendarEvent.title
        addDatePickerView.datePickerDate = calendarEvent.date
        addTextView.textViewText = calendarEvent.memo
    }
    
    // MARK: - Actions
        
    @objc func touchCancelButton(_ sender: UIBarButtonItem) {
        delegate?.todoAddControllerDidCancel(self)
    }
    
    @objc func touchSaveButton(_ sender: UIBarButtonItem) {
        guard let calendarEvent = calendarEvent else { return }
        delegate?.todoAddControllerDidSave(self, calendarEvent)
    }

}

// MARK: - AddTextFieldViewDelegate

extension TodoAddController: AddTextFieldViewDelegate {
    func addTextFieldChange(_ text: String) {
        guard let calendarEvent = calendarEvent else { return }
        navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
        calendarEvent.title = text
    }
}

// MARK: - AddDatePickerViewDlegate

extension TodoAddController: AddDatePickerViewDlegate {
    func addDatePickerDateChange(_ date: Date) {
        guard let calendarEvent = calendarEvent else { return }
        calendarEvent.date = date
    }
}

// MARK: - AddTextViewDelegate

extension TodoAddController: AddTextViewDelegate {
    func addTextViewChange(_ text: String) {
        guard let calendarEvent = calendarEvent else { return }
        calendarEvent.memo = text
    }
}
