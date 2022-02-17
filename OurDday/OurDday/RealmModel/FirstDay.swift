//
//  FirstDay.swift
//  OurDday
//
//  Created by rae on 2022/02/17.
//

import Foundation
import RealmSwift

class FirstDay: Object {
    @objc dynamic var key: String = "FirstDay"
    @objc dynamic var date: Date = Date()
    
    override class func primaryKey() -> String? {
        return "key"
    }
}
