//
//  HomeInformation.swift
//  OurDday
//
//  Created by rae on 2022/03/31.
//

import Foundation

struct HomeInformation {
    var photoURL: URL?
    var profileFirstURL: URL?
    var profileSecondURL: URL?
    var date: Date
}

extension HomeInformation {
    static let EMPTY = HomeInformation(photoURL: nil,
                                       profileFirstURL: nil,
                                       profileSecondURL: nil,
                                       date: Date())
}
