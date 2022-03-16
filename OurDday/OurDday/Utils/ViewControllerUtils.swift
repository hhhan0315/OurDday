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
        nav.navigationBar.tintColor = UIColor.white
        nav.navigationBar.barTintColor = UIColor.mainColor
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        nav.view.backgroundColor = UIColor.backgroundColor
        return nav
    }
    
    static func configureTemplateNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.navigationBar.tintColor = UIColor.white
        nav.navigationBar.barTintColor = UIColor.mainColor
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        nav.view.backgroundColor = UIColor.backgroundColor
        return nav
    }
}
