//
//  ViewControllerUtils.swift
//  OurDday
//
//  Created by rae on 2022/02/23.
//

import UIKit

extension UIViewController {
    static func configureTemplateNavigationController(unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = UIColor.customColor(.textColor)
        nav.navigationBar.barTintColor = UIColor.customColor(.mainColor)
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.customColor(.textColor)]
        return nav
    }
    
    static func configureTemplateNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.navigationBar.tintColor = UIColor.customColor(.textColor)
        nav.navigationBar.barTintColor = UIColor.customColor(.mainColor)
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.customColor(.textColor)]
        return nav
    }
}
