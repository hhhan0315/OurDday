//
//  HomeController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit
import WidgetKit
import CropViewController
import PhotosUI
import SideMenu

final class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    
//    private var todayCount: Int?

    // MARK: - Life cycle
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        
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
//        if #available(iOS 14.0, *) {
//            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(touchGearButton))
//        } else {
//            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(touchGearButton))
//        }
    }
    
    private func updateAnimate() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.homeView.alpha = 0.5
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0.1) {
                self.homeView.alpha = 1.0
                self.viewModel.updateUser()
                self.homeView.setUser(self.viewModel.user())
            }
        }
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
        let sideMenuNavController = SideMenuNavController(rootViewController: SideMenuController())
        present(sideMenuNavController, animated: true)
    }
}

// MARK: - SideMenuNavigationControllerDelegate

extension HomeController: SideMenuNavigationControllerDelegate {
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        updateAnimate()
    }
}
