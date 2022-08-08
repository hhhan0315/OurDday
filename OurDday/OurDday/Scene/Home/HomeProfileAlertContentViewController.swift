//
//  HomeProfileAlertContentViewController.swift
//  OurDday
//
//  Created by rae on 2022/08/07.
//

import UIKit

class HomeProfileAlertContentViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "face.smiling"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
}
