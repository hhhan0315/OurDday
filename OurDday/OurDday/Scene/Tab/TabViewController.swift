//
//  TabViewController.swift
//  OurDday
//
//  Created by rae on 2022/08/08.
//

import UIKit
import Tabman
import Pageboy

class TabViewController: TabmanViewController {
    private let viewControllers = [HomeViewController(), EventViewController()]
    private let titles = ["우리", "디데이"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 0)
        bar.backgroundView.style = .blur(style: .regular)
        
        bar.buttons.customize { button in
            button.tintColor = .lightGray
            button.selectedTintColor = .mainColor
            button.font = .customFont(.title3) ?? .systemFont(ofSize: 20.0)
        }
        
        bar.indicator.tintColor = .mainColor
        bar.indicator.overscrollBehavior = .compress
        
        addBar(bar, dataSource: self, at: .top)
    }
}

extension TabViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

extension TabViewController: TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: titles[index])
    }
}
