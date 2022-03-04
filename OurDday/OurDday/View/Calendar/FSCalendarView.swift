//
//  FSCalendarView.swift
//  OurDday
//
//  Created by rae on 2022/03/02.
//

import UIKit
import FSCalendar

protocol FSCalendarViewDelegate: AnyObject {
    func fsCalendarChoose(_ date: Date)
}

class FSCalendarView: UIView {
    
    // MARK: - Properties

    weak var delegate: FSCalendarViewDelegate?
    var calendarEvents: [CalendarEvent]? {
        didSet {
            calendar.reloadData()
        }
    }

    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.locale = Locale(identifier: "ko_kr")
        calendar.appearance.weekdayTextColor = .darkGray
        calendar.appearance.titleWeekendColor = .red
        calendar.appearance.todayColor = .customColor(.mainColor)
        calendar.appearance.selectionColor = .darkGray
        calendar.headerHeight = 0
        return calendar
    }()
    
    private lazy var prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(touchPrevButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(touchNextButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.middleSemiBold)
        label.text = calendar.currentPage.toCalendarHeaderLabel()
        return label
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prevButton, headerLabel, nextButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubview(calendar)
        addSubview(headerStackView)
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: .customSize(.anchorSpace)),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .customSize(.anchorSpace) * 2),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.customSize(.anchorSpace) * 2),
            headerStackView.heightAnchor.constraint(equalToConstant: 44.0),
            
            calendar.topAnchor.constraint(equalTo: headerStackView.bottomAnchor),
            calendar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .customSize(.anchorSpace)),
            calendar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.customSize(.anchorSpace)),
            calendar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.customSize(.anchorSpace)),
        ])
    }

    private func moveCurrentPage(moveUp: Bool) {
        let moveDate = Calendar.current.date(byAdding: .month, value: moveUp ? 1 : -1, to: calendar.currentPage) ?? Date()
        calendar.setCurrentPage(moveDate, animated: true)
        headerLabel.text = calendar.currentPage.toCalendarHeaderLabel()
    }
    
    private func calendarEventsHaveDate(date: Date) -> Bool {
        guard let calendarEvents = calendarEvents else {
            return false
        }
        
        let dateEvents = calendarEvents.map { $0.dateString }
        if dateEvents.contains(date.toCalendarDateString()) {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Actions
    
    @objc func touchPrevButton(_ sender: UIButton) {
        moveCurrentPage(moveUp: false)
    }
    
    @objc func touchNextButton(_ sender: UIButton) {
        moveCurrentPage(moveUp: true)
    }
}

// MARK: - FSCalendarDelegate

extension FSCalendarView: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate?.fsCalendarChoose(date)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        headerLabel.text = calendar.currentPage.toCalendarHeaderLabel()
    }
}

// MARK: - FSCalendarDataSource

extension FSCalendarView: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return calendarEventsHaveDate(date: date) ? 1 : 0
    }
}

// MARK: - FSCalendarDelegateAppearance

extension FSCalendarView: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        return calendarEventsHaveDate(date: date) ? [UIColor.customColor(.mainColor)] : nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        return calendarEventsHaveDate(date: date) ? [UIColor.customColor(.mainColor)] : nil
    }
}
