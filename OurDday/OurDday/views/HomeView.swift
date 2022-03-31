//
//  HomeView.swift
//  OurDday
//
//  Created by rae on 2022/03/29.
//

import UIKit

final class HomeView: UIView {
    
    let phrasesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.wordRegular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.bigHomeBold)
        label.textAlignment = .center
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.dateRegular)
        label.textAlignment = .center
        return label
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(phrasesLabel)
        addSubview(dateLabel)
        addSubview(countLabel)
        addSubview(backgroundImageView)
        
        bringSubviewToFront(phrasesLabel)
        bringSubviewToFront(dateLabel)
        bringSubviewToFront(countLabel)
        
        phrasesLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 16.0),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            phrasesLabel.bottomAnchor.constraint(equalTo: countLabel.topAnchor, constant: -16.0),
            phrasesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            phrasesLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            phrasesLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
