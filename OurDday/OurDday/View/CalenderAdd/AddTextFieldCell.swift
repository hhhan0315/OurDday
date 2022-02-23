//
//  AddTextFieldCell.swift
//  OurDday
//
//  Created by rae on 2022/02/23.
//

import UIKit

final class AddTextFieldCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "AddTextFieldCell"
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "제목"
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        return textField
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
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - UITextFieldDelegate

extension AddTextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
