//
//  TodoController.swift
//  OurDday
//
//  Created by rae on 2022/03/07.
//

import UIKit

protocol TodoControllerDelegate: AnyObject {
    func todoControllerDidTrash(_ controller: TodoController, _ calendarEvent: CalendarEvent)
    func todoControllerDidBack(_ controller: TodoController)
}

class TodoController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: TodoControllerDelegate?
    
    var calendarEvent: CalendarEvent? {
        didSet {
            configureCalendarEvent()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.customFontSize(.middleSystem)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = UIFont.customFontSize(.middleSystem)
        return label
    }()
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = UIFont.customFontSize(.middleSystem)
        return label
    }()
    
    private let titleView: TodoTitleDateView = {
        let view = TodoTitleDateView()
        view.layer.cornerRadius = CGFloat.customSize(.cornerRadius)
        view.backgroundColor = .white
        return view
    }()
    
    private let dateView: TodoTitleDateView = {
        let view = TodoTitleDateView()
        view.layer.cornerRadius = CGFloat.customSize(.cornerRadius)
        view.backgroundColor = .white
        return view
    }()
    
    private let memoView: TodoMemoView = {
        let view = TodoMemoView()
        view.layer.cornerRadius = CGFloat.customSize(.cornerRadius)
        view.backgroundColor = .white
        return view
    }()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate?.todoControllerDidBack(self)
    }

    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        
        navigationItem.title = "일정 세부사항"
        
        let trashBarButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(touchTrashButton(_:)))
        let editBarButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(touchEditButton(_:)))
        
        navigationItem.setRightBarButtonItems([editBarButton, trashBarButton], animated: true)
        
        view.addSubview(titleLabel)
        view.addSubview(titleView)
        view.addSubview(dateLabel)
        view.addSubview(dateView)
        view.addSubview(memoLabel)
        view.addSubview(memoView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateView.translatesAutoresizingMaskIntoConstraints = false
        memoLabel.translatesAutoresizingMaskIntoConstraints = false
        memoView.translatesAutoresizingMaskIntoConstraints = false
        
        let anchorSpace = CGFloat.customSize(.anchorSpace)
        let doubleAnchorSpace = CGFloat.customSize(.anchorSpace) * 2
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: doubleAnchorSpace),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -doubleAnchorSpace),
            titleLabel.heightAnchor.constraint(equalToConstant: 44.0),
            
            titleView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: anchorSpace),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -anchorSpace),
            titleView.heightAnchor.constraint(equalToConstant: 44.0),
            
            dateLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            
            dateView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            dateView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            dateView.heightAnchor.constraint(equalToConstant: 44.0),
            
            memoLabel.topAnchor.constraint(equalTo: dateView.bottomAnchor),
            memoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            memoLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            memoLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            
            memoView.topAnchor.constraint(equalTo: memoLabel.bottomAnchor),
            memoView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            memoView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            memoView.heightAnchor.constraint(equalToConstant: 255.0),
        ])
    }
    
    private func configureCalendarEvent() {
        guard let calendarEvent = calendarEvent else { return }
        
        titleView.labelContent = calendarEvent.title
        dateView.labelContent = calendarEvent.date.toStringWithDayOfTheWeek()
        memoView.textContent = calendarEvent.memo
    }
    
    // MARK: - Actions
    
    @objc func touchTrashButton(_ sender: UIBarButtonItem) {
        guard let calendarEvent = calendarEvent else { return }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
//        alertController.title = "일정 삭제"
//        alertController.message = "일정을 삭제하시겠습니까?"
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.delegate?.todoControllerDidTrash(self, calendarEvent)
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func touchEditButton(_ sender: UIBarButtonItem) {
        guard let calendarEvent = calendarEvent else { return }
        
        let todoAddController = TodoAddController()
        todoAddController.calendarEvent = calendarEvent
        todoAddController.delegate = self
        let nav = TodoController.configureTemplateNavigationController(rootViewController: todoAddController)
        present(nav, animated: true, completion: nil)
    }
}

extension TodoController: TodoAddControllerDelegate {
    func todoAddControllerDidSave(_ controller: TodoAddController, _ calendarEvent: CalendarEvent) {
        RealmManager.shared.update(calendarEvent: calendarEvent, completion: { check in
            if check {
                self.calendarEvent = calendarEvent
                controller.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    func todoAddControllerDidCancel(_ controller: TodoAddController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
