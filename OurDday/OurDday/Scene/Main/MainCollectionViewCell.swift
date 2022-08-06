//
//  MainCollectionViewCell.swift
//  OurDday
//
//  Created by rae on 2022/08/05.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: MainCollectionViewCell.self)
        
    // MARK: - UI Define
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.title3)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }()
    
    private let underBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor
        view.alpha = 0
        return view
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? UIColor.mainColor : UIColor.lightGray
            underBar.alpha = isSelected ? 1 : 0
        }
    }
    
    // MARK: - Layout
    private func setupViews() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        [titleLabel, underBar].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        [titleLabel, underBar].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            underBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            underBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            underBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            underBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3.0),
            underBar.heightAnchor.constraint(equalToConstant: 3.0),
        ])
    }
    
    // MARK: - Configure
    func configureCell(with text: String) {
        titleLabel.text = text
    }
}
