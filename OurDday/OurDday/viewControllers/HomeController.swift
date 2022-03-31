//
//  HomeController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit
import WidgetKit
import CropViewController
import PhotosUI

final class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let homeView = HomeView()
    private let localStorage = LocalStorage()
    private let imageKeyName = "homeBackGroundImage"
    
    private var todayCount: Int?

    // MARK: - Life cycle
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        updateLabelContents()
        updateImageAndColor()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        checkTodayCount()
//
//        if #available(iOS 13.0, *) {
//            NotificationCenter.default.addObserver(self, selector: #selector(checkTodayCount), name: UIScene.willEnterForegroundNotification, object: nil)
//        } else {
//            NotificationCenter.default.addObserver(self, selector: #selector(checkTodayCount), name: UIApplication.willEnterForegroundNotification, object: nil)
//        }
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//        NotificationCenter.default.removeObserver(self)
//    }
    
    // MARK: - Helpers
    
    private func configureNav() {
        navigationItem.title = "디데이"
        
        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(touchGearButton))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(touchGearButton))
        }
    }
    
    private func updateLabelContents() {
        todayCount = EventManager.shared.getTodayCount()
        guard let todayCount = todayCount else { return }
        let phrasesText = localStorage.readPhrases()
        
        homeView.phrasesLabel.text = phrasesText
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
    
    // MARK: - Actions
    
//    @objc func checkTodayCount() {
//        let newTodayCount = EventManager.shared.getTodayCount()
//        
//        if todayCount != newTodayCount {
//            todayCount = newTodayCount
//        }
//    }
    
    @objc func touchGearButton() {
        let alertController = UIAlertController(title: "설정", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        alertController.addAction(UIAlertAction(title: "문구 설정", style: .default, handler: { _ in
            let phrasesAlert = UIAlertController(title: "문구 설정", message: nil, preferredStyle: .alert)
            phrasesAlert.addTextField { textField in
                let phrases = self.localStorage.readPhrases()
                textField.text = phrases
                textField.clearButtonMode = .whileEditing
                textField.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
                textField.font = UIFont.systemFont(ofSize: 17.0)
            }
            phrasesAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
            phrasesAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                guard let phrases = phrasesAlert.textFields?[0].text else { return }
                LocalStorage().setPhrases(phrases: phrases)
                
                if #available(iOS 14.0, *) {
                    WidgetCenter.shared.reloadAllTimelines()
                }
                
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                    self.homeView.phrasesLabel.alpha = 0.5
                } completion: { _ in
                    UIView.animate(withDuration: 0.3, delay: 0) {
                        self.updateLabelContents()
                        self.homeView.phrasesLabel.alpha = 1.0
                    }
                }
            }))
            self.present(phrasesAlert, animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "기념일 설정", style: .default, handler: { _ in
            let contentController = ContentDatePickerController()
            
            let dateAlert = UIAlertController(title: "기념일 설정", message: nil, preferredStyle: .alert)
            dateAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
            dateAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                self.localStorage.setFirstDate(date: contentController.datePicker.date)
                
                if #available(iOS 14.0, *) {
                    WidgetCenter.shared.reloadAllTimelines()
                }
                
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                    self.homeView.countLabel.alpha = 0.5
                    self.homeView.dateLabel.alpha = 0.5
                } completion: { _ in
                    UIView.animate(withDuration: 0.3, delay: 0) {
                        self.updateLabelContents()
                        self.homeView.countLabel.alpha = 1.0
                        self.homeView.dateLabel.alpha = 1.0
                    }
                }
            }))
            dateAlert.setValue(contentController, forKey: "contentViewController")
            
            self.present(dateAlert, animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "배경화면 설정", style: .default, handler: { _ in
            
            let photoController = UIAlertController(title: "배경화면 설정", message: nil, preferredStyle: .actionSheet)
            photoController.addAction(UIAlertAction(title: "앨범에서 선택", style: .default, handler: { _ in
                if #available(iOS 14, *) {
                    var configuration = PHPickerConfiguration()
                    configuration.selectionLimit = 1
                    configuration.filter = .images
                    
                    let picker = PHPickerViewController(configuration: configuration)
                    picker.delegate = self
                    self.present(picker, animated: true, completion: nil)
                } else {
                    let picker = UIImagePickerController()
                    picker.delegate = self
                    picker.sourceType = .photoLibrary
                    self.present(picker, animated: true, completion: nil)
                }
            }))
            photoController.addAction(UIAlertAction(title: "배경화면 사용 안함", style: .default, handler: { _ in
                let removeAlertController = UIAlertController(title: "배경화면 사용 안함", message: "배경화면을 사용하지 않겠습니까?", preferredStyle: .alert)
                removeAlertController.addAction(UIAlertAction(title: "취소", style: .cancel))
                removeAlertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                    PhotoManager.shared.removeImageFromDocumentDirectory(imageName: self.imageKeyName)
                    
                    if #available(iOS 14.0, *) {
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                        self.homeView.phrasesLabel.alpha = 0.5
                        self.homeView.countLabel.alpha = 0.5
                        self.homeView.dateLabel.alpha = 0.5
                        self.homeView.backgroundImageView.alpha = 0.5
                    } completion: { _ in
                        UIView.animate(withDuration: 0.3, delay: 0) {
                            self.updateImageAndColor()
                            self.homeView.phrasesLabel.alpha = 1.0
                            self.homeView.countLabel.alpha = 1.0
                            self.homeView.dateLabel.alpha = 1.0
                            self.homeView.backgroundImageView.alpha = 1.0
                        }
                    }
                }))
                self.present(removeAlertController, animated: true)
            }))
            photoController.addAction(UIAlertAction(title: "취소", style: .cancel))
            self.present(photoController, animated: true)
            
        }))
        
        present(alertController, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension HomeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let cropViewController = CropViewController(image: image)
            cropViewController.delegate = self
            cropViewController.customAspectRatio = CGSize(width: homeView.backgroundImageView.frame.width, height: homeView.backgroundImageView.frame.height)
            cropViewController.resetAspectRatioEnabled = false
            cropViewController.aspectRatioPickerButtonHidden = true
            present(cropViewController, animated: true, completion: nil)
        }
    }
}

// MARK: - PHPickerViewControllerDelegate

extension HomeController: PHPickerViewControllerDelegate {
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        let itemProvider = results.first?.itemProvider

        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage else { return }
                
                DispatchQueue.main.async {
                    let cropViewController = CropViewController(image: image)
                    cropViewController.delegate = self
                    cropViewController.customAspectRatio = CGSize(width: self.homeView.backgroundImageView.frame.width, height: self.homeView.backgroundImageView.frame.height)
                    cropViewController.resetAspectRatioEnabled = false
                    cropViewController.aspectRatioPickerButtonHidden = true
                    self.present(cropViewController, animated: true, completion: nil)
                }
                
            }
        }
    }
}

// MARK: - CropViewControllerDelegate

extension HomeController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        PhotoManager.shared.saveImageToDocumentDirectory(imageName: imageKeyName, image: image)
        
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.homeView.phrasesLabel.alpha = 0.5
            self.homeView.countLabel.alpha = 0.5
            self.homeView.dateLabel.alpha = 0.5
            self.homeView.backgroundImageView.alpha = 0.5
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.updateImageAndColor()
                self.homeView.phrasesLabel.alpha = 1.0
                self.homeView.countLabel.alpha = 1.0
                self.homeView.dateLabel.alpha = 1.0
                self.homeView.backgroundImageView.alpha = 1.0
            }
        }
        
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
