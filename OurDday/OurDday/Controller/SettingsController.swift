//
//  SettingsController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class SettingsController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = SettingsViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        tableView.separatorInset.right = tableView.separatorInset.left
        tableView.rowHeight = 64.0
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let settingsDayController = SettingsDayController()
            navigationController?.pushViewController(settingsDayController, animated: true)
        }
    }
}
