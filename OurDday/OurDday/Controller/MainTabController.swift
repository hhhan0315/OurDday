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
        
        let home = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"), rootViewController: HomeController())
        
        let day = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"), rootViewController: EventController())
        
        let calendar = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"), rootViewController: CalendarController())
        
        let settings = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"), rootViewController: SettingsController())
        
        viewControllers = [home, day, calendar, settings]
        
        tabBar.tintColor = UIColor.mainColor
    }
    
}
