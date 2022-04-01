//
//  FirstLaunchView.swift
//  OurDday
//
//  Created by rae on 2022/03/29.
//

import UIKit

final class FirstLaunchView: UIView {
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 처음 만난 날"
        label.font = UIFont.customFontSize(.bigBold)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜를 선택해주세요"
        label.font = UIFont.customFontSize(.middleSystem)
        label.textColor = UIColor.darkGrayColor
        return label
    }()
    
    let dateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Date().toButtonStringKST(), for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = UIColor.backgroundColor

        addSubview(titleLabel)
        addSubview(infoLabel)
        addSubview(dateButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        dateButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -125),

            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),

            dateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            dateButton.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
}
