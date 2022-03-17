//
//  HomeController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit
import CropViewController
import PhotosUI

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
        label.font = UIFont.customFontSize(.bigBold)
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
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchBackgroundView(_:))))
        return imageView
    }()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        todayCount = EventManager.shared.getTodayCount()
        backgroundImageView.image = PhotoManager.shared.loadImageFromDocumentDirectory(imageName: imageKeyName) ?? UIImage(named: "initialBackground")
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
            countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50.0),
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            dateLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 15.0),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 50.0),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25.0),
        ])
    }
    
    private func configureLabel() {
        guard let todayCount = todayCount else { return }

        countLabel.text = "\(todayCount + 1)일"
        dateLabel.text = RealmManager.shared.readFirstDayDate().toButtonStringKST()
    }
    
    // MARK: - Actions
    
    @objc func touchBackgroundView(_ sender: UITapGestureRecognizer) {
        
        if #available(iOS 14, *) {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 1
            configuration.filter = .images
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        } else {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        }
    }
    
    @objc func checkTodayCount() {
        let newTodayCount = EventManager.shared.getTodayCount()
        
        if todayCount != newTodayCount {
            todayCount = newTodayCount
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension HomeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let cropViewController = CropViewController(image: image)
            cropViewController.delegate = self
            cropViewController.customAspectRatio = CGSize(width: self.backgroundImageView.frame.width, height: self.backgroundImageView.frame.height)
            cropViewController.resetAspectRatioEnabled = false
            cropViewController.aspectRatioPickerButtonHidden = true
            present(cropViewController, animated: true, completion: nil)
        }
    }
}

// MARK: - CropViewControllerDelegate

extension HomeController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        PhotoManager.shared.saveImageToDocumentDirectory(imageName: imageKeyName, image: image)
        backgroundImageView.image = image
        cropViewController.dismiss(animated: true, completion: nil)
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
                    cropViewController.customAspectRatio = CGSize(width: self.backgroundImageView.frame.width, height: self.backgroundImageView.frame.height)
                    cropViewController.resetAspectRatioEnabled = false
                    cropViewController.aspectRatioPickerButtonHidden = true
                    self.present(cropViewController, animated: true, completion: nil)
                }
                
            }
        }
    }
}
