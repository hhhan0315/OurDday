//
//  HomeController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit
import WidgetKit

final class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let homeView = HomeView()
    private let imageKeyName = "homeBackGroundImage"
    
    private var todayCount: Int? {
        didSet {
            configureLabel()
        }
    }

    // MARK: - Life cycle
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        todayCount = EventManager.shared.getTodayCount()
        updateImageAndColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkTodayCount()
        
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(checkTodayCount), name: UIScene.willEnterForegroundNotification, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(checkTodayCount), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Helpers
    
    private func configureNav() {
        navigationItem.title = "디데이"
        
        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(touchGearButton))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(touchGearButton))
        }
    }
    
    private func configureLabel() {
        updatePhrasesLabel()
        guard let todayCount = todayCount else { return }
        homeView.countLabel.text = "\(todayCount + 1)일"
        homeView.dateLabel.text = LocalStorage().readFirstDate().toButtonStringKST()
    }
    
    private func updateImageAndColor() {
        homeView.backgroundImageView.image = PhotoManager.shared.loadImageFromDocumentDirectory(imageName: imageKeyName)
        
        if homeView.backgroundImageView.image == nil {
            homeView.phrasesLabel.textColor = UIColor.black
            homeView.countLabel.textColor = UIColor.mainColor
            homeView.dateLabel.textColor = UIColor.darkGrayColor
        } else {
            homeView.phrasesLabel.textColor = UIColor.white
            homeView.countLabel.textColor = UIColor.white
            homeView.dateLabel.textColor = UIColor.white
        }
    }
    
    private func updatePhrasesLabel() {
        let phrasesText = UserDefaults.shared?.string(forKey: "phrases") ?? ""
        homeView.phrasesLabel.text = phrasesText
    }
    
    // MARK: - Actions
    
    @objc func checkTodayCount() {
        let newTodayCount = EventManager.shared.getTodayCount()
        
        if todayCount != newTodayCount {
            todayCount = newTodayCount
        }
    }
    
    @objc func touchGearButton() {
        let alertController = UIAlertController(title: "설정", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        alertController.addAction(UIAlertAction(title: "기념일 설정", style: .default, handler: { _ in
            
        }))
        alertController.addAction(UIAlertAction(title: "배경화면 설정", style: .default, handler: { _ in
            
        }))
        alertController.addAction(UIAlertAction(title: "문구 설정", style: .default, handler: { _ in
            
        }))
        present(alertController, animated: true)
    }
}

// MARK: - SettingsControllerDelegate

extension HomeController: SettingsControllerDelegate {
    func settingsControllerImageSave() {
        updateImageAndColor()
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    func settingsControllerPhrasesSave() {
        updatePhrasesLabel()
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
