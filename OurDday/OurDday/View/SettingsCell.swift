//
//  SettingsCell.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/10.
//

import UIKit

final class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SettingsCell"
    
    var viewModel: SettingsCellViewModel? {
        didSet {
            configureViewModel()
        }
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.middleSystem)
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
        addSubview(iconImageView)
        addSubview(titleLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .customSize(.anchorSpace)),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: .customSize(.anchorSpace)),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.customSize(.anchorSpace)),
            iconImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: .customSize(.anchorSpace)),
        ])
    }
    
    private func configureViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        iconImageView.image = UIImage(systemName: viewModel.iconName)
        titleLabel.text = viewModel.title
    }
}
