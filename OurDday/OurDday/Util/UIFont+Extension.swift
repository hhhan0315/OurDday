//
//  UIFont+Extension.swift
//  OurDday
//
//  Created by rae on 2022/02/22.
//

import UIKit

enum CustomFontSize {
    case largeTitle
    case title3
    case body
}

extension UIFont {
    static func customFont(_ name: CustomFontSize) -> UIFont? {
        switch name {
        case .largeTitle:
            return UIFont(name: "BMJUA", size: 34.0)
        case .title3:
            return UIFont(name: "BMJUA", size: 20.0)
        case .body:
            return UIFont(name: "BMJUA", size: 17.0)
        }
    }
}
