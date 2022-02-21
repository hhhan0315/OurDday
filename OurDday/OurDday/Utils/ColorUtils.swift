//
//  Color.swift
//  OurDday
//
//  Created by rae on 2022/02/21.
//

import UIKit

enum AssetsColor {
    case mainColor
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .mainColor:
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
