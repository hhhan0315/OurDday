//
//  HomeViewController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

protocol HomeControllerDelegate: AnyObject {
    func homeControllerImageSize(_ width: CGFloat, _ height: CGFloat)
}

final class HomeViewController: UIViewController {
    // MARK: - View Define
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Properties
    private let viewModel = HomeViewModel()
    
    weak var delegate: HomeControllerDelegate?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        setupViews()
        
        configureNav()
        configureNotification()
        
        viewModel.updateUser()
//        homeView.setUser(viewModel.user())
    }
    
    // MARK: - Layout
    private func setupViews() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        [photoImageView].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        [photoImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureNav() {
        
    }
    
    private func updateViewModel() {
        self.viewModel.updateUser()
//        self.homeView.setUser(self.viewModel.user())
    }
    
    private func configureNotification() {
//        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationColorChange), name: Notification.Name.colorChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationTimeChange), name: UIApplication.significantTimeChangeNotification, object: nil)
    }
    
    // MARK: - Objc
    @objc func handleNotificationColorChange() {
//        homeView.setUser(viewModel.user())
    }
    
    @objc func handleNotificationTimeChange() {
//        homeView.setUser(viewModel.user())
    }
}

// MARK: - SideMenuControllerDeleagte

//extension HomeController: SideMenuControllerDeleagte {
//    func sideMenuControllerDidSave() {
//        updateViewModel()
//    }
//}
