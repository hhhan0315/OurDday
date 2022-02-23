//
//  MainTabController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

protocol TabBarReselctHandling {
    func handleReselect()
}

final class MainTabController: UITabBarController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        delegate = self
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let home = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"), rootViewController: HomeController())
        
        let day = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"), rootViewController: SpecialDayController())
        
        let calendar = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"), rootViewController: CalendarController())
        
        let settings = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"), rootViewController: SettingsController())
        
        viewControllers = [home, day, calendar, settings]
        
        tabBar.tintColor = UIColor.customColor(.mainColor)
    }
    
}

// MARK: - UITabBarControllerDelegate

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navigationController = viewController as? UINavigationController {
            if navigationController.viewControllers.count <= 1,
               let handler = navigationController.viewControllers.first as? TabBarReselctHandling {
                handler.handleReselect()
            }
        }
    }
}
