//
//  SpecialDayCell.swift
//  OurDday
//
//  Created by rae on 2022/02/18.
//

import UIKit

final class SpecialDayCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "SpecialDaysCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.middleBold)
        return label
    }()
    
    let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.smallSystem)
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.middleBold)
        return label
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
        addSubview(titleLabel)
        addSubview(dateTitleLabel)
        addSubview(countLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            
            dateTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10.0),
            dateTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
        ])
    }
    
    func configure(event: Event) {
        let dayCount = event.dayCount
        
        titleLabel.text = event.title
        titleLabel.textColor = dayCount > 0 ? UIColor.lightGray : UIColor.black
        
        countLabel.text = dayCount == 0 ? "오늘" : dayCount > 0 ? "" : "D\(dayCount)"
        countLabel.textColor = dayCount > 0 ? UIColor.lightGray : UIColor.customColor(.mainColor)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd(EEE)"
        formatter.locale = Locale(identifier: "ko_kr")
        
        dateTitleLabel.text = formatter.string(from: event.date)
        dateTitleLabel.textColor = dayCount > 0 ? UIColor.lightGray : UIColor.darkGray
    }
}
