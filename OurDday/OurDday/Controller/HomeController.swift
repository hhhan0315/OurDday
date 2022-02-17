//
//  HomeController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "sample")
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1일"
        return label
    }()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "디데이"
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
