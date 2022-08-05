//
//  SettingViewController.swift
//  OurDday
//
//  Created by rae on 2022/08/05.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: - View Define
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifer)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
        
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
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
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
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
        // delegate로 변경된 것 수정
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
//        let rows = getRows(section: indexPath.section)
//        let z = rows[indexPath.row]
//        print(z)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
