//
//  HomeViewController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit
import Combine
import PhotosUI
import CropViewController

protocol HomeViewControllerDelegate: AnyObject {
//    func homeControllerImageSize(_ width: CGFloat, _ height: CGFloat)
//    func resetFirstPageViewController()
//    func setPhotoImageView()
}

// TODO: Home -> Delegate로 Main으로 전달 -> 사진 선택 & 종류별로 이제 사진 고름 -> identifier에 따라 해당 이미지뷰에 사진 설정 & PageViewController set 다시

final class HomeViewController: UIViewController {
    // MARK: - View Define
//    private let photoImageView = HomePhotoImageView(frame: .zero)
//    private let profileFirstImageView = HomeProfileFirstImageView(frame: .zero)
//    private let profileSecondImageView = HomeProfileSecondImageView(frame: .zero)
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "photo"))
        return imageView
    }()
    
    private lazy var profileFirstImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "face.smiling"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.tintColor = .lightGray
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchProfileFirstImageView(_:))))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var profileSecondImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "face.smiling"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.tintColor = .lightGray
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchProfileSecondImageView(_:))))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let heartImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = UIColor.mainColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1일"
        label.textAlignment = .center
        label.font = UIFont.customFont(.title3)
        return label
    }()
    
    private let meetDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.customFont(.body)
        return label
    }()
    
    private lazy var heartDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heartImageView, dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return stackView
    }()
    
    // MARK: - Properties
    private let viewModel = HomeViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    weak var delegate: HomeViewControllerDelegate?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        viewModel.fetch()
        
        setupViews()
        setupBind()
        setupNotification()
    }
    
    // MARK: - Layout
    private func setupViews() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        [photoImageView, heartDateStackView, profileFirstImageView, profileSecondImageView, meetDateLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        [photoImageView, heartDateStackView, profileFirstImageView, profileSecondImageView, meetDateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoImageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            
            heartDateStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20.0),
            heartDateStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heartDateStackView.widthAnchor.constraint(equalToConstant: 100.0),
            heartDateStackView.heightAnchor.constraint(equalToConstant: 100.0),
            
            profileFirstImageView.topAnchor.constraint(equalTo: heartDateStackView.topAnchor),
            profileFirstImageView.centerYAnchor.constraint(equalTo: heartDateStackView.centerYAnchor),
            profileFirstImageView.widthAnchor.constraint(equalToConstant: 100.0),
            profileFirstImageView.heightAnchor.constraint(equalToConstant: 100.0),
            profileFirstImageView.trailingAnchor.constraint(equalTo: heartDateStackView.leadingAnchor, constant: -16.0),
            
            profileSecondImageView.topAnchor.constraint(equalTo: heartDateStackView.topAnchor),
            profileSecondImageView.centerYAnchor.constraint(equalTo: heartDateStackView.centerYAnchor),
            profileSecondImageView.widthAnchor.constraint(equalToConstant: 100.0),
            profileSecondImageView.heightAnchor.constraint(equalToConstant: 100.0),
            profileSecondImageView.leadingAnchor.constraint(equalTo: heartDateStackView.trailingAnchor, constant: 16.0),
            
            meetDateLabel.topAnchor.constraint(equalTo: heartDateStackView.bottomAnchor, constant: 10.0),
            meetDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            meetDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    // MARK: - Bind
    private func setupBind() {
        viewModel.$homeInformation
            .receive(on: DispatchQueue.main)
            .sink { homeInformation in
                //                self.photoImageView.image = homeInformation.photoURL ?? UIImage(named: "photo")
                self.dateLabel.text = "\(Calendar.countDaysFromNow(fromDate: homeInformation.date) + 1)일"
                self.meetDateLabel.text = DateFormatter().toYearMonthDay(date: LocalStorageManager.shared.readDate())
            }
            .store(in: &cancellable)
    }
    
    // MARK: - Notification
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationChangeDate), name: Notification.Name.changeDate, object: nil)
    }
    
    @objc private func notificationChangeDate() {
        viewModel.fetch()
    }
    
    // MARK: - Method
    private func setPHPickerConfiguration() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    // MARK: - Objc
    @objc private func touchProfileFirstImageView(_ sender: UIImageView) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "수정", style: .destructive, handler: { _ in
            self.setPHPickerConfiguration()
        }))
//        alert.view.tintColor = UIColor.mainColor
        
        let contentViewController = HomeProfileAlertContentViewController()
        alert.setValue(contentViewController, forKey: "contentViewController")
        present(alert, animated: true)
//        view.superview
    }
    
    @objc private func touchProfileSecondImageView(_ sender: UIImageView) {
        print("second")
    }
}

// MARK: - PHPickerViewControllerDelegate
extension HomeViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        let itemProvider = results.first?.itemProvider

        if let itemProvider = itemProvider,
            itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage else {
                    return
                }
//                DispatchQueue.main.async {
//                    self.photoImageView.image = image
//                }
                DispatchQueue.main.async {
                    let cropViewController = CropViewController(image: image)
                    cropViewController.delegate = self
//                    cropViewController.customAspectRatio = CGSize(width: self.imageWidth, height: self.imageHeight)
//                    cropViewController.resetAspectRatioEnabled = false
//                    cropViewController.aspectRatioPickerButtonHidden = true
//                    cropViewController.modalPresentationStyle = .popover
                    self.present(cropViewController, animated: true, completion: nil)
                }
            }
        }
    }
}

// MARK: - CropViewControllerDelegate
extension HomeViewController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        // TODO: PhotoManager에서 저장 (case 분류 필요)
        cropViewController.dismiss(animated: true) {
//            self.delegate?.resetFirstPageViewController()
        }
        
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true) {
//            self.delegate?.resetFirstPageViewController()
        }
    }
}
