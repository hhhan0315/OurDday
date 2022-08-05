//
//  HomeInformation.swift
//  OurDday
//
//  Created by rae on 2022/03/31.
//

import Foundation

struct HomeInformation {
    var photoURL: URL?
    var myImageURL: URL?
    var youImageURL: URL?
    var date: Date
}

extension HomeInformation {
    static let EMPTY = HomeInformation(photoURL: nil,
                                       myImageURL: nil,
                                       youImageURL: nil,
                                       date: Date())
}
