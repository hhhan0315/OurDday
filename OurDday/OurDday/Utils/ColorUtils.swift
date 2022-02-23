//
//  Color.swift
//  OurDday
//
//  Created by rae on 2022/02/21.
//

import UIKit

enum CustomColor {
    case mainColor
    case textColor
}

extension UIColor {
    static func customColor(_ name: CustomColor) -> UIColor {
        switch name {
        case .mainColor:
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case .textColor:
            return UIColor.white
        }
    }
}
