//
//  CalendarAddController.swift
//  OurDday
//
//  Created by rae on 2022/02/23.
//

import UIKit

protocol TodoAddControllerDelegate: AnyObject {
    func todoAddControllerDidSave(_ controller: TodoAddController, _ calendarEventStruct: CalendarEventStruct)
    func todoAddControllerDidCancel(_ controller: TodoAddController)
}

final class TodoAddController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: TodoAddControllerDelegate?
    
    var calendarEventStruct: CalendarEventStruct? {
        didSet {
            configureCalendarEvent()
        }
    }
    
    private lazy var addTextFieldView: AddTextFieldView = {
        let view = AddTextFieldView()
        view.delegate = self
        view.layer.cornerRadius = CGFloat.customSize(.cornerRadius)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private lazy var addDatePickerView: AddDatePickerView = {
        let view = AddDatePickerView()
        view.delegate = self
        view.layer.cornerRadius = CGFloat.customSize(.cornerRadius)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private lazy var addTextView: AddTextView = {
        let view = AddTextView()
        view.delegate = self
        view.layer.cornerRadius = CGFloat.customSize(.cornerRadius)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
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
        view.backgroundColor = .backgroundColor
        
        guard let calendarEventStruct = calendarEventStruct else { return }
        
        navigationItem.title = calendarEventStruct.title.isEmpty ? "새로운 일정" : "일정 수정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchCancelButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: calendarEventStruct.title.isEmpty ? "추가" : "완료", style: .plain, target: self, action: #selector(touchSaveButton(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = !calendarEventStruct.title.isEmpty
        
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
            addTextFieldView.heightAnchor.constraint(equalToConstant: 40.0),
            
            addDatePickerView.topAnchor.constraint(equalTo: addTextFieldView.bottomAnchor, constant: anchorSpace),
            addDatePickerView.leadingAnchor.constraint(equalTo: addTextFieldView.leadingAnchor),
            addDatePickerView.trailingAnchor.constraint(equalTo: addTextFieldView.trailingAnchor),
            addDatePickerView.heightAnchor.constraint(equalToConstant: 150.0),
            
            addTextView.topAnchor.constraint(equalTo: addDatePickerView.bottomAnchor, constant: anchorSpace),
            addTextView.leadingAnchor.constraint(equalTo: addDatePickerView.leadingAnchor),
            addTextView.trailingAnchor.constraint(equalTo: addDatePickerView.trailingAnchor),
            addTextView.heightAnchor.constraint(equalToConstant: 150.0),
        ])
    }
    
    private func configureCalendarEvent() {
        guard let calendarEventStruct = calendarEventStruct else { return }

        addTextFieldView.textFieldText = calendarEventStruct.title
        addDatePickerView.datePickerDate = calendarEventStruct.date
        addTextView.textViewText = calendarEventStruct.memo
    }
    
    // MARK: - Actions
        
    @objc func touchCancelButton(_ sender: UIBarButtonItem) {
        delegate?.todoAddControllerDidCancel(self)
    }
    
    @objc func touchSaveButton(_ sender: UIBarButtonItem) {
        guard let calendarEventStruct = calendarEventStruct else { return }
        delegate?.todoAddControllerDidSave(self, calendarEventStruct)
    }

}

// MARK: - AddTextFieldViewDelegate

extension TodoAddController: AddTextFieldViewDelegate {
    func addTextFieldChange(_ text: String) {
        navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
        calendarEventStruct?.title = text
    }
}

// MARK: - AddDatePickerViewDlegate

extension TodoAddController: AddDatePickerViewDlegate {
    func addDatePickerDateChange(_ date: Date) {
        calendarEventStruct?.date = date
    }
}

// MARK: - AddTextViewDelegate

extension TodoAddController: AddTextViewDelegate {
    func addTextViewChange(_ text: String) {
        calendarEventStruct?.memo = text
    }
}
