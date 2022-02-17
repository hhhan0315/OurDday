//
//  LocalStorage.swift
//  OurDday
//
//  Created by rae on 2022/02/17.
//

import Foundation

struct LocalStorage {
    private let defaults: UserDefaults
    private let key = "isFirstLaunch"
    
    init(with defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }
    
    func isFirstLaunch() -> Bool {
        if defaults.object(forKey: key) == nil {
            return true
        } else {
            return false
        }
    }
    
    func setFirstTime() {
        defaults.set("No", forKey: key)
    }
}
