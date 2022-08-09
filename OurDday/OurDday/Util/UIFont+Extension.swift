//
//  UIFont+Extension.swift
//  OurDday
//
//  Created by rae on 2022/02/22.
//

import UIKit

enum CustomFontSize {
    case largeTitle
    case title1
    case title3
    case body
}

enum CustomFontName {
    static let bmjua = "BMJUA"
}

extension UIFont {
    static func customFont(_ name: CustomFontSize) -> UIFont? {
        switch name {
        case .largeTitle:
            return UIFont(name: CustomFontName.bmjua, size: 34.0)
        case .title1:
            return UIFont(name: CustomFontName.bmjua, size: 28.0)
        case .title3:
            return UIFont(name: CustomFontName.bmjua, size: 20.0)
        case .body:
            return UIFont(name: CustomFontName.bmjua, size: 17.0)
        }
    }
}
