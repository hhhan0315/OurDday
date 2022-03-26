//
//  AddTextView.swift
//  OurDday
//
//  Created by rae on 2022/03/04.
//

import UIKit

protocol AddTextViewDelegate: AnyObject {
    func addTextViewChange(_ text: String)
}

class AddTextView: UIView {

    // MARK: - Properties
    
    weak var delegate: AddTextViewDelegate?
    
    var textViewText: String? {
        didSet {
            guard let textViewText = textViewText else { return }

            if !textViewText.isEmpty {
                textView.text = textViewText
                textView.textColor = .black
            }
        }
    }
    
    private let textViewPlaceholder = "메모"
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.customFontSize(.middleSystem)
        textView.delegate = self
        textView.text = textViewPlaceholder
        textView.textColor = .systemGray3
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
            textView.topAnchor.constraint(equalTo: topAnchor, constant: anchorSpace),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: anchorSpace),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -anchorSpace),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -anchorSpace),
        ])
    }
}

// MARK: - UITextViewDelegate

extension AddTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = .systemGray3
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            delegate?.addTextViewChange(text)
        }
    }
}
