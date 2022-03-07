//
//  TodoMemoView.swift
//  OurDday
//
//  Created by rae on 2022/03/07.
//

import UIKit

class TodoMemoView: UIView {

    // MARK: - Properties
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = UIFont.customFontSize(.middleSystem)
        textView.textColor = .darkGray
        return textView
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
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        let anchorSpace = CGFloat.customSize(.anchorSpace)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: anchorSpace),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -anchorSpace),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configureTextView(content: String) {
        textView.text = content
    }

}
