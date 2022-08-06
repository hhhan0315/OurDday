//
//  HomeViewController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit
import Combine

protocol HomeControllerDelegate: AnyObject {
    func homeControllerImageSize(_ width: CGFloat, _ height: CGFloat)
}

final class HomeViewController: UIViewController {
    // MARK: - View Define
    private let photoImageView = HomePhotoImageView(frame: .zero)
    private let profileFirstImageView = HomeProfileFirstImageView(frame: .zero)
    private let profileSecondImageView = HomeProfileSecondImageView(frame: .zero)
    
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
    
    weak var delegate: HomeControllerDelegate?
    
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
}
