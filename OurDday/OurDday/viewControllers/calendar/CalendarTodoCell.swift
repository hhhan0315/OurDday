//
//  CalendarTodoCell.swift
//  OurDday
//
//  Created by rae on 2022/02/23.
//

import UIKit

final class CalendarTodoCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "CalendarCell"
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.borderWidth = 0.33
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
