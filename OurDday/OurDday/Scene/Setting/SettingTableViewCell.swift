//
//  SettingTableViewCell.swift
//  OurDday
//
//  Created by rae on 2022/08/05.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let identifer = String(describing: SettingTableViewCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.body)
        label.textColor = UIColor.textColor
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configureCell(with title: String?) {
        titleLabel.text = title
    }
}
