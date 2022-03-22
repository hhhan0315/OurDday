//
//  SettingsController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit
import CropViewController
import PhotosUI

protocol SettingsControllerDelegate: AnyObject {
    func settingsControllerImageSave(_ controller: SettingsController)
}

final class SettingsController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: SettingsControllerDelegate?
    
    private let imageKeyName = "homeBackGroundImage"
    
    private let viewModel = SettingsViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        tableView.separatorInset.right = tableView.separatorInset.left
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "설정"
        navigationItem.backButtonTitle = ""
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource

extension SettingsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        
        let setting = viewModel.setting(at: indexPath.row)
        let settingsCellViewModel = SettingsCellViewModel(setting: setting)
        cell.viewModel = settingsCellViewModel
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let settingsDayController = SettingsDayController()
            navigationController?.pushViewController(settingsDayController, animated: true)
        case 1:
            let alertController = UIAlertController(title: "배경화면 설정", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "앨범에서 선택", style: .default, handler: { _ in
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
            alertController.addAction(UIAlertAction(title: "배경화면 사용 안함", style: .default, handler: { _ in
                let removeAlertController = UIAlertController(title: "배경화면 사용 안함", message: "배경화면을 사용하지 않겠습니까?", preferredStyle: .alert)
                removeAlertController.addAction(UIAlertAction(title: "취소", style: .cancel))
                removeAlertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                    PhotoManager.shared.removeImageFromDocumentDirectory(imageName: self.imageKeyName)
                    self.delegate?.settingsControllerImageSave(self)
                }))
                self.present(removeAlertController, animated: true)
            }))
            alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
            present(alertController, animated: true)
        default:
            break
        }

    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension SettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let cropViewController = CropViewController(image: image)
            cropViewController.delegate = self
            cropViewController.customAspectRatio = CGSize(width: view.frame.width, height: view.frame.height - (self.navigationController?.navigationBar.frame.height ?? 0) - (self.tabBarController?.tabBar.frame.height ?? 0))
            cropViewController.resetAspectRatioEnabled = false
            cropViewController.aspectRatioPickerButtonHidden = true
            present(cropViewController, animated: true, completion: nil)
        }
    }
}

// MARK: - CropViewControllerDelegate

extension SettingsController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        PhotoManager.shared.saveImageToDocumentDirectory(imageName: imageKeyName, image: image)
        delegate?.settingsControllerImageSave(self)
        
        cropViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - PHPickerViewControllerDelegate

extension SettingsController: PHPickerViewControllerDelegate {
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
                    cropViewController.customAspectRatio = CGSize(width: self.view.frame.width, height: self.view.frame.height - (self.navigationController?.navigationBar.frame.height ?? 0) - (self.tabBarController?.tabBar.frame.height ?? 0))
                    cropViewController.resetAspectRatioEnabled = false
                    cropViewController.aspectRatioPickerButtonHidden = true
                    self.present(cropViewController, animated: true, completion: nil)
                }
                
            }
        }
    }
}
