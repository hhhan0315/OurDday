//
//  HomeProfileAlertContentViewController.swift
//  OurDday
//
//  Created by rae on 2022/08/07.
//

import UIKit

class HomeProfileAlertContentViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "smile"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
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
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func configureImageView(imageFileType: ImageFileType) {
        switch imageFileType {
        case .photo:
            break
        case .profileFirst:
            if let profileFirstURL = LocalStorageManager.shared.readProfileFirstURL(),
               let profileFirstImage = UIImage(contentsOfFile: profileFirstURL.path) {
                self.imageView.image = profileFirstImage
            }
        case .profileSecond:
            if let profileSecondURL = LocalStorageManager.shared.readProfileSecondURL(),
               let profileSecondPhoto = UIImage(contentsOfFile: profileSecondURL.path) {
                self.imageView.image = profileSecondPhoto
            }
        }
    }
}
