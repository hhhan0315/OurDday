//
//  AddTextFieldView.swift
//  OurDday
//
//  Created by rae on 2022/03/03.
//

import UIKit

protocol AddTextFieldCellDelegate: AnyObject {
    func addTextFieldChange(_ text: String)
}

class AddTextFieldView: UIView {

    // MARK: - Properties
    
    weak var delegate: AddTextFieldCellDelegate?
        
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "제목"
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
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
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if let text = sender.text {
            delegate?.addTextFieldChange(text)
        }
    }
}

// MARK: - UITextFieldDelegate

extension AddTextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
