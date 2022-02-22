//
//  SettingsController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class SettingsController: UITableViewController {
    
    // MARK: - Properties
    
    private let titles = ["기념일 설정", "테마 설정"]

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "설정"
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset.right = tableView.separatorInset.left
        tableView.rowHeight = 80
        tableView.isScrollEnabled = false
    }
}

// MARK: - UITableViewDataSource

extension SettingsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = titles[indexPath.row]
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let next = SettingsDayController()
            navigationController?.pushViewController(next, animated: true)
        }
    }
}
