//
//  MainViewController.swift
//  OurDday
//
//  Created by rae on 2022/08/05.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - View Define
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 25
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = self
        return pageViewController
    }()
    
    // MARK: - Properties
    private let viewModel = MainViewModel()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        setFirstIndexIsSelected()
        setFirstViewController()
    }
    
    // MARK: - Layout
    private func setupViews() {
        addSubviews()
        makeConstraints()
        setupNavigation()
    }
    
    private func addSubviews() {
        [collectionView, pageViewController.view].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        [collectionView, pageViewController.view].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            collectionView.heightAnchor.constraint(equalToConstant: 44.0),
            
            pageViewController.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupNavigation() {
        navigationItem.title = "우리 디데이"
        // 폰트 수정
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - Menu CollectionView Method
    private func setFirstIndexIsSelected() {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
    }
    
    private func setFirstViewController() {
        if let firstViewController = viewModel.firstViewController() {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true)
        }
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
