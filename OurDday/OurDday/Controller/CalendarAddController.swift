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
    
    private var calendarEvent = CalendarEvent()
    
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
        
        navigationItem.title = "새로운 일정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchCancelButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(touchAddButton(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
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
    
    func configureDatePickerDate(date: Date) {
        addDatePickerView.configure(date: date)
        calendarEvent.date = date
    }
    
    // MARK: - Actions
        
    @objc func touchCancelButton(_ sender: UIBarButtonItem) {
        delegate?.calendarAddControllerDidCancel(self)
    }
    
    @objc func touchAddButton(_ sender: UIBarButtonItem) {
        delegate?.calendarAddControllerDidSave(self, calendarEvent)
    }

}

// MARK: - AddTextFieldViewDelegate

extension CalendarAddController: AddTextFieldViewDelegate {
    func addTextFieldChange(_ text: String) {
        navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
        calendarEvent.title = text
    }
}

// MARK: - AddTextViewDelegate

extension CalendarAddController: AddTextViewDelegate {
    func addTextViewChange(_ text: String) {
        calendarEvent.memo = text
    }
}

extension CalendarAddController: AddDatePickerViewDlegate {
    func addDatePickerDateChange(_ date: Date) {
        calendarEvent.date = date
    }
}
