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
    
    private let imageKeyName = "homeBackGroundImage"
    
    private var todayCount: Int? {
        didSet {
            configureLabel()
        }
    }
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainColor
        label.font = UIFont.customFontSize(.bigHomeBold)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor
        label.font = UIFont.customFontSize(.middleSemiBold)
        return label
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        todayCount = EventManager.shared.getTodayCount()
        backgroundImageView.image = PhotoManager.shared.loadImageFromDocumentDirectory(imageName: imageKeyName)
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
    
    private func configureUI() {
        navigationItem.title = "디데이"
                
        view.addSubview(countLabel)
        view.addSubview(dateLabel)
        view.addSubview(backgroundImageView)
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            dateLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 15.0),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureLabel() {
        guard let todayCount = todayCount else { return }

        countLabel.text = "\(todayCount + 1)일"
        dateLabel.text = RealmManager.shared.readFirstDayDate().toButtonStringKST()
    }
    
    // MARK: - Actions
    
    @objc func checkTodayCount() {
        let newTodayCount = EventManager.shared.getTodayCount()
        
        if todayCount != newTodayCount {
            todayCount = newTodayCount
        }
    }
}

// MARK: - SettingsControllerDelegate

extension HomeController: SettingsControllerDelegate {
    func settingsControllerImageSave(_ controller: SettingsController) {
        backgroundImageView.image = PhotoManager.shared.loadImageFromDocumentDirectory(imageName: imageKeyName)
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
