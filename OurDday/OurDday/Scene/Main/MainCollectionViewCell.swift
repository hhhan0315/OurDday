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
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    //    override var isHighlighted: Bool {
    //        didSet {
    //            titleLabel.textColor = isSelected ? UIColor.mainColor : UIColor.gray
    //
    //            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
    ////                self.menuUnderBar.layoutIfNeeded()
    ////                self.menuUnderBar.alpha = self.isSelected ? 1 : 0
    //            }, completion: nil)
    //        }
    //    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? UIColor.mainColor : UIColor.lightGray
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                //                self.menuUnderBar.layoutIfNeeded()
                //                self.menuUnderBar.alpha = self.isSelected ? 1 : 0
            }, completion: nil)
        }
    }
    
    // MARK: - Layout
    private func setupViews() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        [titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        [titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    // MARK: - Configure
    func configureCell(with text: String) {
        titleLabel.text = text
    }
}
