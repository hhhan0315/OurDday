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
        label.textColor = .darkGray
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
}
