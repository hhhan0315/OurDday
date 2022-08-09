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
    
    private lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .mainColor
        button.addTarget(self, action: #selector(touchSettingButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupBar()
        setupSettingButton()
    }
    
    private func setupBar() {
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
    
    private func setupSettingButton() {
        view.addSubview(settingButton)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingButton.widthAnchor.constraint(equalToConstant: 45.0),
            settingButton.heightAnchor.constraint(equalToConstant: 45.0),
        ])
    }
    
    @objc private func touchSettingButton(_ sender: UIButton) {
        let settingViewController = SettingViewController()
        let navigationController = UINavigationController(rootViewController: settingViewController)
        present(navigationController, animated: true)
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
