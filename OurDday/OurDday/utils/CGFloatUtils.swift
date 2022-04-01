//
//  CGFloatUtils.swift
//  OurDday
//
//  Created by rae on 2022/03/04.
//

import UIKit

enum CustomCGFloatSize {
    case anchorSpace
    case cornerRadius
}

extension CGFloat {
    static func customSize(_ name: CustomCGFloatSize) -> CGFloat {
        switch name {
        case .anchorSpace:
            return 16.0
        case .cornerRadius:
            return 7.0
        }
    }
}
