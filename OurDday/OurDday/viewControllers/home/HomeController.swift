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
    
//    private var todayCount: Int?

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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        checkTodayCount()
//
//        if #available(iOS 13.0, *) {
//            NotificationCenter.default.addObserver(self, selector: #selector(checkTodayCount), name: UIScene.willEnterForegroundNotification, object: nil)
//        } else {
//            NotificationCenter.default.addObserver(self, selector: #selector(checkTodayCount), name: UIApplication.willEnterForegroundNotification, object: nil)
//        }
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//        NotificationCenter.default.removeObserver(self)
//    }
    
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
    }
    
    // MARK: - Actions
    
//    @objc func checkTodayCount() {
//        let newTodayCount = EventManager.shared.getTodayCount()
//        
//        if todayCount != newTodayCount {
//            todayCount = newTodayCount
//        }
//    }
    
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
}

// MARK: - SideMenuControllerDeleagte

extension HomeController: SideMenuControllerDeleagte {
    func sideMenuControllerDidSave() {
        updateViewModel()
    }
}
