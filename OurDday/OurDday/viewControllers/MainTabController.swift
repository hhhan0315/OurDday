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
        configureNotification()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        
        let day = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"), rootViewController: EventController())
        
        let home = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"), rootViewController: HomeController())
        
        let calendar = MainTabController.configureTemplateNavigationController(unselectedImage: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"), rootViewController: CalendarController())
        
        viewControllers = [home, day, calendar]
        
        setTintColor()
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationColorChange), name: Notification.Name.colorChange, object: nil)
    }
    
    private func setTintColor() {
        tabBar.tintColor = LocalStorage().colorForKey()
    }
    
    @objc func handleNotificationColorChange() {
        setTintColor()
    }
    
}
