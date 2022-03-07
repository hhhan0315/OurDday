//
//  TodoTitleView.swift
//  OurDday
//
//  Created by rae on 2022/03/07.
//

import UIKit

class TodoTitleDateView: UIView {

    // MARK: - Properties
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.middleSystem)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let anchorSpace = CGFloat.customSize(.anchorSpace)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: anchorSpace),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -anchorSpace),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configureLabel(content: String) {
        label.text = content
    }

}
