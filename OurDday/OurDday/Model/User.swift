//
//  User.swift
//  OurDday
//
//  Created by rae on 2022/03/31.
//

import Foundation

struct User {
    var imageUrl: URL?
    var date: Date
    var phrases: String
}

extension User {
    static let EMPTY = User(imageUrl: nil, date: Date(), phrases: "")
}
