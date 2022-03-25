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
    
    private let phrasesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.wordRegular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.bigHomeBold)
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFontSize(.dateRegular)
        label.textAlignment = .center
        return label
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
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
    
    private func configureUI() {
        navigationItem.title = "디데이"
        
        view.addSubview(phrasesLabel)
        view.addSubview(dateLabel)
        view.addSubview(countLabel)
        view.addSubview(backgroundImageView)
        
        view.bringSubviewToFront(phrasesLabel)
        view.bringSubviewToFront(dateLabel)
        view.bringSubviewToFront(countLabel)
        
        phrasesLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 16.0),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phrasesLabel.bottomAnchor.constraint(equalTo: countLabel.topAnchor, constant: -16.0),
            phrasesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phrasesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            phrasesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureLabel() {
        updatePhrasesLabel()
        guard let todayCount = todayCount else { return }
        countLabel.text = "\(todayCount + 1)일"
        dateLabel.text = RealmManager.shared.readFirstDayDate().toButtonStringKST()
    }
    
    private func updateImageAndColor() {
        backgroundImageView.image = PhotoManager.shared.loadImageFromDocumentDirectory(imageName: imageKeyName)
        
        if backgroundImageView.image == nil {
            phrasesLabel.textColor = UIColor.black
            countLabel.textColor = UIColor.mainColor
            dateLabel.textColor = UIColor.darkGrayColor
        } else {
            phrasesLabel.textColor = UIColor.white
            countLabel.textColor = UIColor.white
            dateLabel.textColor = UIColor.white
        }
    }
    
    private func updatePhrasesLabel() {
        let phrasesText = UserDefaults.shared?.string(forKey: "phrases") ?? ""
        phrasesLabel.text = phrasesText
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
