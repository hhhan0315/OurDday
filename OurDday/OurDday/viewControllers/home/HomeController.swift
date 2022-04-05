//
//  HomeController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

protocol HomeControllerDelegate: AnyObject {
    func homeControllerImageSize(_ width: CGFloat, _ height: CGFloat)
}

final class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    
    weak var delegate: HomeControllerDelegate?
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        configureNotification()
        
        viewModel.updateUser()
        homeView.setUser(viewModel.user())
    }
    
    // MARK: - Helpers
    
    private func configureNav() {
        navigationItem.title = "디데이"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(touchLineButton))
    }
    
    private func updateViewModel() {
        self.viewModel.updateUser()
        self.homeView.setUser(self.viewModel.user())
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationColorChange), name: Notification.Name.colorChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationTimeChange), name: UIApplication.significantTimeChangeNotification, object: nil)
    }
    
    // MARK: - Actions
    
    @objc func touchLineButton() {
        let sideMenuController = SideMenuController()
        sideMenuController.delegate = self
        delegate = sideMenuController
        delegate?.homeControllerImageSize(homeView.backgroundImageView.frame.width, homeView.backgroundImageView.frame.height)
        
        let sideMenuNavController = SideMenuNavController(rootViewController: sideMenuController)
        present(sideMenuNavController, animated: true)
    }
    
    @objc func handleNotificationColorChange() {
        homeView.setUser(viewModel.user())
        navigationController?.navigationBar.tintColor = LocalStorage().colorForKey()
    }
    
    @objc func handleNotificationTimeChange() {
        homeView.setUser(viewModel.user())
    }
}

// MARK: - SideMenuControllerDeleagte

extension HomeController: SideMenuControllerDeleagte {
    func sideMenuControllerDidSave() {
        updateViewModel()
    }
}
