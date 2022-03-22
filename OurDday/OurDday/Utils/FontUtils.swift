//
//  FontUtils.swift
//  OurDday
//
//  Created by rae on 2022/02/22.
//

import UIKit

enum CustomFontSize {
    case bigHomeBold
    case bigBold
    case middleSemiBold
    case middleSystem
    case smallSystem
}

extension UIFont {
    static func customFontSize(_ name: CustomFontSize) -> UIFont {
        switch name {
        case .bigHomeBold:
            return UIFont.boldSystemFont(ofSize: 48.0)
        case .bigBold:
            return UIFont.boldSystemFont(ofSize: 34.0)
        case .middleSemiBold:
            return UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        case .middleSystem:
            return UIFont.systemFont(ofSize: 17.0)
        case .smallSystem:
            return UIFont.systemFont(ofSize: 13.0)
        }
    }
}
