//
//  FontUtils.swift
//  OurDday
//
//  Created by rae on 2022/02/22.
//

import UIKit

enum CustomFontSize {
    case bigBold
    case middleBold
    case middleSystem
    case smallSystem
}

extension UIFont {
    static func customFontSize(_ name: CustomFontSize) -> UIFont {
        switch name {
        case .bigBold:
            return UIFont.boldSystemFont(ofSize: 32.0)
        case .middleBold:
            return UIFont.boldSystemFont(ofSize: 18.0)
        case .middleSystem:
            return UIFont.systemFont(ofSize: 18.0)
        case .smallSystem:
            return UIFont.systemFont(ofSize: 14.0)
        }
    }
}
