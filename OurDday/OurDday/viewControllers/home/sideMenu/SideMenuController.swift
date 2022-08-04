////
////  SideMenuController.swift
////  OurDday
////
////  Created by rae on 2022/04/01.
////
//
//import UIKit
////import SideMenu
//import WidgetKit
//import PhotosUI
////import CropViewController
//
//protocol SideMenuControllerDeleagte: AnyObject {
//    func sideMenuControllerDidSave()
//}
//
//class SideMenuNavController: SideMenuNavigationController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.leftSide = true
//        self.presentDuration = 0.5
//        self.dismissDuration = 0.5
//        self.presentationStyle = .menuSlideIn
//        self.presentationStyle.presentingEndAlpha = 0.6
//        self.menuWidth = view.frame.width * 0.6
//    }
//    
//}
//
//class SideMenuController: UITableViewController {
//    
//    private let viewModel = SideMenuViewModel()
//    private let localStorage = LocalStorage()
//    
//    private var imageWidth: CGFloat = 0
//    private var imageHeight: CGFloat = 0
//    
//    weak var delegate: SideMenuControllerDeleagte?
//        
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        configureUI()
//        configureNotification()
//    }
//    
//    private func configureUI() {
//        navigationItem.title = "설정"
//        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sideCell")
//        tableView.separatorInset.right = tableView.separatorInset.left
//    }
//    
//    private func configureNotification() {
//        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationColorChange), name: Notification.Name.colorChange, object: nil)
//    }
//    
//    private func updateWidgetCenter() {
//        if #available(iOS 14.0, *) {
//            WidgetCenter.shared.reloadAllTimelines()
//        }
//    }
//    
//    @objc func handleNotificationColorChange() {
//        updateWidgetCenter()
//        DispatchQueue.main.async {
//            self.dismiss(animated: true)
//        }
//    }
//}
//
//extension SideMenuController {
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.settingsCount()
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "sideCell", for: indexPath)
//        
//        let settingTitle = viewModel.setting(at: indexPath.row)
//        
//        cell.textLabel?.text = settingTitle
//        
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        // ["기념일 설정", "문구 설정", "배경화면 설정", "배경화면 사용 안함", "색상 변경"]
//        switch indexPath.row {
//        case 0:
//            let contentController = ContentDatePickerController()
//
//            let dateAlert = UIAlertController(title: "기념일 설정", message: nil, preferredStyle: .alert)
//            dateAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
//            dateAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
//                self.localStorage.setFirstDate(date: contentController.datePicker.date)
//                self.updateWidgetCenter()
//                self.delegate?.sideMenuControllerDidSave()
//                self.dismiss(animated: true)
//            }))
//            dateAlert.setValue(contentController, forKey: "contentViewController")
//
//            present(dateAlert, animated: true, completion: nil)
//            
//        case 1:
//            let phrasesAlert = UIAlertController(title: "문구 설정", message: nil, preferredStyle: .alert)
//            phrasesAlert.addTextField { textField in
//                let phrases = self.localStorage.readPhrases()
//                textField.text = phrases
//                textField.clearButtonMode = .whileEditing
//                textField.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
//                textField.font = UIFont.systemFont(ofSize: 17.0)
//            }
//            phrasesAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
//            phrasesAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
//                guard let phrases = phrasesAlert.textFields?[0].text else { return }
//                self.localStorage.setPhrases(phrases: phrases)
//                self.updateWidgetCenter()
//                self.delegate?.sideMenuControllerDidSave()
//                self.dismiss(animated: true)
//            }))
//            present(phrasesAlert, animated: true)
//            
//        case 2:
//            if #available(iOS 14, *) {
//                var configuration = PHPickerConfiguration()
//                configuration.selectionLimit = 1
//                configuration.filter = .images
//
//                let picker = PHPickerViewController(configuration: configuration)
//                picker.delegate = self
//                self.present(picker, animated: true, completion: nil)
//            } else {
//                let picker = UIImagePickerController()
//                picker.delegate = self
//                picker.sourceType = .photoLibrary
//                self.present(picker, animated: true, completion: nil)
//            }
//            
//        case 3:
//            let removeAlertController = UIAlertController(title: "배경화면 사용 안함", message: nil, preferredStyle: .alert)
//            removeAlertController.addAction(UIAlertAction(title: "취소", style: .cancel))
//            removeAlertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
//                PhotoManager.shared.removeImageFromDocumentDirectory()
//                self.updateWidgetCenter()
//                self.delegate?.sideMenuControllerDidSave()
//                self.dismiss(animated: true)
//            }))
//            present(removeAlertController, animated: true)
//            
//        case 4:
//            if #available(iOS 14.0, *) {
//                let colorNav = SideMenuController.configureTemplateNavigationController(rootViewController: ColorPickerController())
//                present(colorNav, animated: true)
//            } else {
//                let colorAlert = UIAlertController(title: "버전 오류", message: "iOS 14부터 가능합니다.", preferredStyle: .alert)
//                colorAlert.addAction(UIAlertAction(title: "확인", style: .cancel))
//                present(colorAlert, animated: true)
//            }
//            
//            
//        default: break
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 75.0
//    }
//}
//
//// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
//
//extension SideMenuController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        picker.dismiss(animated: true, completion: nil)
//        
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            let cropViewController = CropViewController(image: image)
//            cropViewController.delegate = self
//            cropViewController.customAspectRatio = CGSize(width: self.imageWidth, height: self.imageHeight)
//            cropViewController.resetAspectRatioEnabled = false
//            cropViewController.aspectRatioPickerButtonHidden = true
//            present(cropViewController, animated: true, completion: nil)
//        }
//    }
//}
//
//// MARK: - PHPickerViewControllerDelegate
//
//extension SideMenuController: PHPickerViewControllerDelegate {
//    @available(iOS 14, *)
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true, completion: nil)
//
//        let itemProvider = results.first?.itemProvider
//
//        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
//            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
//                guard let image = image as? UIImage else { return }
//                
//                DispatchQueue.main.async {
//                    let cropViewController = CropViewController(image: image)
//                    cropViewController.delegate = self
//                    cropViewController.customAspectRatio = CGSize(width: self.imageWidth, height: self.imageHeight)
//                    cropViewController.resetAspectRatioEnabled = false
//                    cropViewController.aspectRatioPickerButtonHidden = true
//                    self.present(cropViewController, animated: true, completion: nil)
//                }
//                
//            }
//        }
//    }
//}
//
//// MARK: - CropViewControllerDelegate
//
//extension SideMenuController: CropViewControllerDelegate {
//    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
//        PhotoManager.shared.saveImageToDocumentDirectory(image: image)
//        updateWidgetCenter()
//        delegate?.sideMenuControllerDidSave()
//        
//        cropViewController.dismiss(animated: true, completion: nil)
//    }
//}
//
//// MARK: - HomeControllerDelegate
//
//extension SideMenuController: HomeControllerDelegate {
//    func homeControllerImageSize(_ width: CGFloat, _ height: CGFloat) {
//        imageWidth = width
//        imageHeight = height
//    }
//}
