//
//  MainViewModel.swift
//  OurDday
//
//  Created by rae on 2022/08/05.
//

import UIKit

final class MainViewModel {
    @Published var currentIndex: Int
    private var titles: [String]
    private var viewControllers: [UIViewController]
    
    init() {
        self.currentIndex = 0
        self.titles = ["우리", "기념일"]
        self.viewControllers = [HomeViewController(), EventTableViewController()]
    }
    
    func titlesCount() -> Int {
        return titles.count
    }
    
    func title(at index: Int) -> String {
        return titles[index]
    }
    
    func viewControllersCount() -> Int {
        return viewControllers.count
    }
    
    func firstViewController() -> UIViewController? {
        return viewControllers.first
    }
    
    func viewControllerIndex(at viewController: UIViewController) -> Int? {
        return viewControllers.firstIndex(of: viewController)
    }
    
    func viewController(at index: Int) -> UIViewController {
        return viewControllers[index]
    }
    
    func configureCurrentIndex(with index: Int) {
        currentIndex = index
    }
}
