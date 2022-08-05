//
//  MainViewController.swift
//  OurDday
//
//  Created by rae on 2022/08/05.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    // MARK: - View Define
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var gearButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.mainColor
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.addTarget(self, action: #selector(touchGearButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        return pageViewController
    }()
    
    // MARK: - Properties
    private let viewModel = MainViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        setFirstIndexIsSelected()
        setFirstViewController()
        setupBind()
    }
    
    // MARK: - Layout
    private func setupViews() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        [collectionView, gearButton, pageViewController.view].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        [collectionView, gearButton, pageViewController.view].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            collectionView.trailingAnchor.constraint(equalTo: gearButton.leadingAnchor, constant: -16.0),
            collectionView.heightAnchor.constraint(equalToConstant: 50.0),
            
            gearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gearButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            gearButton.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            
            pageViewController.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - Method
    private func setFirstIndexIsSelected() {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
    }
    
    private func setFirstViewController() {
        if let firstViewController = viewModel.firstViewController() {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true)
        }
    }
    
    // MARK: - Bind
    private func setupBind() {
        viewModel.$currentIndex
            .receive(on: DispatchQueue.main)
            .sink { currentIndex in
                let direction: UIPageViewController.NavigationDirection = currentIndex == 0 ? .reverse : .forward
                self.collectionView.selectItem(at: IndexPath(item: currentIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                self.pageViewController.setViewControllers([self.viewModel.viewController(at: currentIndex)], direction: direction, animated: true)
            }.store(in: &cancellable)
    }
    
    // MARK: - Objc
    @objc private func touchGearButton(_ sender: UIButton) {
        let settingViewController = SettingViewController()
        let navigationController = UINavigationController(rootViewController: settingViewController)
        present(navigationController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.titlesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            return .init()
        }
        
        let text = viewModel.title(at: indexPath.item)
        cell.configureCell(with: text)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.configureCurrentIndex(with: indexPath.row)
    }
}

// MARK: - UIPageViewControllerDataSource
extension MainViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewModel.viewControllerIndex(at: viewController) else {
            return nil
        }
        
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return viewModel.viewController(at: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewModel.viewControllerIndex(at: viewController) else {
            return nil
        }
        
        let nextIndex = index + 1
        if nextIndex == viewModel.viewControllersCount() {
            return nil
        }
        return viewModel.viewController(at: nextIndex)
    }
}

// MARK: - UIPageViewControllerDelegate
extension MainViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first,
              let currentIndex = viewModel.viewControllerIndex(at: currentViewController) else {
            return
        }
        viewModel.configureCurrentIndex(with: currentIndex)
    }
}
