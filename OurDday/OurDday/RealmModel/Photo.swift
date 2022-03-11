//
//  Photo.swift
//  OurDday
//
//  Created by rae on 2022/03/10.
//

import Foundation
import RealmSwift

class Photo: Object {
    @objc dynamic var key: String = "Photo"
    @objc dynamic var url: String = ""
    
    override class func primaryKey() -> String? {
        return "key"
    }
}
