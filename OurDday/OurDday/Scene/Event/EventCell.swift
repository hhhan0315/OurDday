//
//  EventCell.swift
//  OurDday
//
//  Created by rae on 2022/02/18.
//

import UIKit

final class EventCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = String(describing: EventCell.self)
    
//    var viewModel: EventCellViewModel? {
//        didSet {
//            configureViewModel()
//        }
//    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.title3)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.body)
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.title3)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // MARK: - Layout
    private func setupViews() {
        addSubviews()
        makeConstraints()
    }
    private func addSubviews() {
        [dateStackView, countLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        [dateStackView, countLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            dateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32.0),
            dateStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            dateStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.0),
        ])
    }
    
//    private func configureViewModel() {
//        guard let viewModel = viewModel else {
//            return
//        }
//        
//        titleLabel.text = viewModel.title
//        titleLabel.textColor = viewModel.count > 0 ? UIColor.lightGray : UIColor.textColor
//        
//        dateLabel.text = viewModel.dateTitle
//        dateLabel.textColor = viewModel.count > 0 ? UIColor.lightGray : UIColor.gray
//        
//        countLabel.text = viewModel.countTitle
//        countLabel.textColor = viewModel.count > 0 ? UIColor.lightGray : UIColor.mainColor
//    }
    
    // MARK: - Configure
    func configureCell(with event: Event) {
        titleLabel.text = event.title
        titleLabel.textColor = event.count > 0 ? UIColor.lightGray : UIColor.textColor
        
        dateLabel.text = event.dateTitle
        dateLabel.textColor = event.count > 0 ? UIColor.lightGray : UIColor.gray
        
        countLabel.text = event.countTitle
        countLabel.textColor = event.count > 0 ? UIColor.lightGray : UIColor.mainColor
    }
    
}
