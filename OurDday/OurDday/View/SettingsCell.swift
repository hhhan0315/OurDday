//
//  SettingsCell.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/10.
//

import UIKit

final class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SettingsCell"
    
    // MARK: - Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
