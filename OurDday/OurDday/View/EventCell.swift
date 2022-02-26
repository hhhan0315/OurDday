//
//  EventCell.swift
//  OurDday
//
//  Created by rae on 2022/02/18.
//

import UIKit

final class EventCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "EventCell"
    
    var viewModel: EventCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.middleBold)
        return label
    }()
    
    private let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.smallSystem)
        return label
    }()
    
    private let countLabel: UILabel = {
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
    
    private func configure() {
        guard let viewModel = viewModel else {
            return
        }
        
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.count > 0 ? UIColor.lightGray : UIColor.black
        
        countLabel.text = viewModel.countTitle
        countLabel.textColor = viewModel.count > 0 ? UIColor.lightGray : UIColor.customColor(.mainColor)
        
        dateTitleLabel.text = viewModel.dateTitle
        dateTitleLabel.textColor = viewModel.count > 0 ? UIColor.lightGray : UIColor.darkGray
    }
    
}
