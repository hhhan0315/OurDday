//
//  FSCalendarCell.swift
//  OurDday
//
//  Created by rae on 2022/02/26.
//

import UIKit
import FSCalendar

protocol FSCalendarCellDelegate: AnyObject {
    func fsCalendarChoose(_ date: Date)
}

final class FSCalendarCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "FSCalendarCell"
    
    weak var delegate: FSCalendarCellDelegate?
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.delegate = self
        calendar.locale = Locale(identifier: "ko_kr")
        calendar.scrollDirection = .vertical
        calendar.appearance.headerDateFormat = "yyyy.MM"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = .darkGray
        calendar.appearance.titleWeekendColor = .red
        calendar.appearance.todayColor = .customColor(.mainColor)
        calendar.appearance.selectionColor = .darkGray
        return calendar
    }()
    
    private lazy var prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor.customColor(.mainColor)
        button.addTarget(self, action: #selector(touchPrevButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor.customColor(.mainColor)
        button.addTarget(self, action: #selector(touchNextButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubview(calendar)
        addSubview(prevButton)
        addSubview(nextButton)
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: topAnchor),
            calendar.leadingAnchor.constraint(equalTo: leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: trailingAnchor),
            calendar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            prevButton.topAnchor.constraint(equalTo: calendar.topAnchor, constant: 15.0),
            prevButton.leadingAnchor.constraint(equalTo: calendar.leadingAnchor, constant: 20.0),
            
            nextButton.topAnchor.constraint(equalTo: calendar.topAnchor, constant: 15.0),
            nextButton.trailingAnchor.constraint(equalTo: calendar.trailingAnchor, constant: -20.0),
        ])
    }

    private func moveCurrentPage(moveUp: Bool) {
        let moveDate = Calendar.current.date(byAdding: .month, value: moveUp ? 1 : -1, to: calendar.currentPage) ?? Date()
        calendar.setCurrentPage(moveDate, animated: true)
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

extension FSCalendarCell: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate?.fsCalendarChoose(date)
    }
}
