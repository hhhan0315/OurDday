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
            configureViewModel()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.middleSemiBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.smallSystem)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.middleSemiBold)
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func updateConstraints() {
        configureConstraints()
        
        super.updateConstraints()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        addSubview(titleLabel)
        addSubview(dateTitleLabel)
        addSubview(countLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .customSize(.anchorSpace)),
            
            dateTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10.0),
            dateTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.customSize(.anchorSpace)),
        ])
    }
    
    private func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.count > 0 ? UIColor.lightGrayColor : UIColor.textColor
        
        countLabel.text = viewModel.countTitle
        countLabel.textColor = viewModel.count > 0 ? UIColor.lightGrayColor : LocalStorage().colorForKey()
        
        dateTitleLabel.text = viewModel.dateTitle
        dateTitleLabel.textColor = viewModel.count > 0 ? UIColor.lightGrayColor : UIColor.darkGrayColor
        
        setNeedsUpdateConstraints()
    }
    
}
