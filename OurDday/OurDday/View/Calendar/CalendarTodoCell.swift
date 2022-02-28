//
//  CalendarTodoCell.swift
//  OurDday
//
//  Created by rae on 2022/02/23.
//

import UIKit

final class CalendarTodoCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "CalendarCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.middleSystem)
        label.numberOfLines = 0
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
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
        ])
    }
    
}
