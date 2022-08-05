//
//  HomeView.swift
//  OurDday
//
//  Created by rae on 2022/03/29.
//

import UIKit

final class HomeView: UIView {
    
    private let phrasesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
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
    
    func setUser(_ user: User) {
        phrasesLabel.text = user.phrases
        countLabel.text = "\(Calendar.countDaysFromNow(fromDate: user.date) + 1)일"
//        dateLabel.text = user.date.toButtonStringKST()
        
        if let url = user.imageUrl,
           let image = UIImage(contentsOfFile: url.path){
            backgroundImageView.image = image
            phrasesLabel.textColor = UIColor.white
            countLabel.textColor = UIColor.white
            dateLabel.textColor = UIColor.white
        } else {
            backgroundImageView.image = nil
            phrasesLabel.textColor = UIColor.black
//            countLabel.textColor = LocalStorageManager.shared.colorForKey()
//            dateLabel.textColor = UIColor.darkGrayColor
        }
    }
}
