//
//  AddDatePickerView.swift
//  OurDday
//
//  Created by rae on 2022/03/03.
//

import UIKit

protocol AddDatePickerViewDlegate: AnyObject {
    func addDatePickerDateChange(_ date: Date)
}

class AddDatePickerView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: AddDatePickerViewDlegate?
    
    var datePickerDate: Date? {
        didSet {
            guard let datePickerDate = datePickerDate else { return }
            
            datePicker.setDate(datePickerDate, animated: false)
        }
    }
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_kr")
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.addTarget(self, action: #selector(datePickerValueChagnge(_:)), for: .valueChanged)
        return datePicker
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
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc func datePickerValueChagnge(_ sender: UIDatePicker) {
        delegate?.addDatePickerDateChange(sender.date)
    }
}
