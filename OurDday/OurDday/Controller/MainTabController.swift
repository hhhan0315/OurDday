//
//  MainTabController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class MainTabController: UITabBarController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let home = configureTemplateNavigationController(unselectedImage: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"), rootViewController: HomeController())
        
        let day = configureTemplateNavigationController(unselectedImage: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"), rootViewController: SpecialDayController())
        
        let calendar = configureTemplateNavigationController(unselectedImage: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"), rootViewController: CalendarController())
        
        let settings = configureTemplateNavigationController(unselectedImage: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"), rootViewController: SettingsController())
        
        viewControllers = [home, day, calendar, settings]
        
        tabBar.tintColor = .black
    }
    
    private func configureTemplateNavigationController(unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .white
        nav.navigationBar.barTintColor = UIColor.customColor(.mainColor)
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        return nav
    }
}
