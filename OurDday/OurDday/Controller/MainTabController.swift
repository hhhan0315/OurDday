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
        
        let homeController = HomeController()
        let home = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"), rootViewController: homeController)
        
        let day = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"), rootViewController: EventController())
        
        let calendar = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"), rootViewController: CalendarController())
        
        let settingsController = SettingsController()
        settingsController.delegate = homeController
        let settings = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"), rootViewController: settingsController)
        
        viewControllers = [home, day, calendar, settings]
        
        tabBar.tintColor = UIColor.mainColor
    }
    
}
