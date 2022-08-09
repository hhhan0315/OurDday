//
//  SettingViewController.swift
//  OurDday
//
//  Created by rae on 2022/08/05.
//

import UIKit
import PhotosUI
import CropViewController
import WidgetKit

class SettingViewController: UIViewController {
    // MARK: - View Define
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifer)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    // MARK: - Layout
    private func setupViews() {
        configureNavigation()
        addSubviews()
        makeConstraints()
    }
    
    private func configureNavigation() {
        navigationItem.title = "설정"
        guard let font = UIFont.customFont(.title3) else {
            return
        }
        let attributes = [NSAttributedString.Key.font: font]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(touchXMarkButton(_:)))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.leftBarButtonItem?.tintColor = UIColor.textColor
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func makeConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    // MARK: - Objc
    @objc private func touchXMarkButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: - Method
    func getRows(section: Int) -> [[String:String]] {
        guard let rows = SettingTableKeys.data[section][SettingTableKeys.Rows] as? [[String:String]] else {
            return [[:]]
        }
        return rows
    }}

// MARK: - UITableViewDataSource
extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getRows(section: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifer, for: indexPath) as? SettingTableViewCell else {
            return .init()
        }
        
        let rows = getRows(section: indexPath.section)
        let title = rows[indexPath.row][SettingTableKeys.Title]
        cell.configureCell(with: title)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingTableKeys.data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionName = SettingTableKeys.data[section][SettingTableKeys.Section] as? String else {
            return nil
        }
        return sectionName
    }
}

// MARK: - UITableViewDelegate
extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = UIColor.mainColor
            headerView.textLabel?.font = UIFont.customFont(.body)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rows = getRows(section: indexPath.section)
        let row = rows[indexPath.row]
        
        switch row[SettingTableKeys.Title] {
        case SettingTableKeys.changeDate:
            let datePickerController = DatePickerViewController()
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                let datePickerDate = datePickerController.datePicker.date
                LocalStorageManager.shared.setDate(date: datePickerDate)
                NotificationCenter.default.post(name: Notification.Name.changeDate, object: nil)
                WidgetCenter.shared.reloadAllTimelines()
                self.dismiss(animated: true)
            }))
            alert.setValue(datePickerController, forKey: "contentViewController")
            
            present(alert, animated: true, completion: nil)
            
        case SettingTableKeys.setPhoto:
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 1
            configuration.filter = .images

            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
        case SettingTableKeys.resetPhoto:
            let title = "초기화하시겠습니까?"
            let attributeString = NSMutableAttributedString(string: title)
            if let titleFont = UIFont.customFont(.body) {
                attributeString.addAttributes([NSAttributedString.Key.font: titleFont],
                                              range: NSRange(location: 0, length: title.count))
            }
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                PhotoManager.shared.removeImageFromDocumentDirectory(imageFileType: .photo)
                NotificationCenter.default.post(name: Notification.Name.resetImage, object: nil)
                WidgetCenter.shared.reloadAllTimelines()
                self.dismiss(animated: true)
            }))
            
            alert.setValue(attributeString, forKey: "attributedTitle")
            present(alert, animated: true, completion: nil)
            
        case SettingTableKeys.resetProfile:
            let title = "초기화하시겠습니까?"
            let attributeString = NSMutableAttributedString(string: title)
            if let titleFont = UIFont.customFont(.body) {
                attributeString.addAttributes([NSAttributedString.Key.font: titleFont],
                                              range: NSRange(location: 0, length: title.count))
            }
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                PhotoManager.shared.removeImageFromDocumentDirectory(imageFileType: .profileFirst)
                PhotoManager.shared.removeImageFromDocumentDirectory(imageFileType: .profileSecond)
                NotificationCenter.default.post(name: Notification.Name.resetImage, object: nil)
                self.dismiss(animated: true)
            }))
            
            alert.setValue(attributeString, forKey: "attributedTitle")
            present(alert, animated: true, completion: nil)
            
        default: break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

// MARK: - PHPickerViewControllerDelegate
extension SettingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        let itemProvider = results.first?.itemProvider

        if let itemProvider = itemProvider,
            itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage else {
                    return
                }
                
                DispatchQueue.main.async {
                    let cropViewController = CropViewController(croppingStyle: .default, image: image)
                    cropViewController.delegate = self
                    cropViewController.resetAspectRatioEnabled = false
                    cropViewController.aspectRatioPickerButtonHidden = true
                    cropViewController.customAspectRatio = CGSize(width: self.view.frame.width, height: self.view.frame.width)
                    
                    self.present(cropViewController, animated: true, completion: nil)
                }
            }
        }
    }
}

// MARK: - CropViewControllerDelegate
extension SettingViewController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        PhotoManager.shared.saveImageToDocumentDirectory(imageFileType: .photo, image: image)
        NotificationCenter.default.post(name: .setPhoto, object: nil)
        WidgetCenter.shared.reloadAllTimelines()
        cropViewController.dismiss(animated: true)
        self.dismiss(animated: true)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true)
        self.dismiss(animated: true)
    }
}
