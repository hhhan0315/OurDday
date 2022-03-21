//
//  LocalStorage.swift
//  OurDday
//
//  Created by rae on 2022/02/17.
//

import Foundation

struct LocalStorage {
    private let defaults: UserDefaults?
    
    init(with defaults: UserDefaults? = UserDefaults.shared) {
        self.defaults = defaults
    }
    
    func isFirstLaunch() -> Bool {
        if defaults?.object(forKey: "isFirstLaunch") == nil {
            return true
        } else {
            return false
        }
    }
    
    func setFirstTime() {
        defaults?.set("No", forKey: "isFirstLaunch")
    }
    
    func setImageUrl(url: URL) {
        defaults?.set(url, forKey: "imageUrl")
    }
    
    func setFirstDate(date: Date) {
        defaults?.set(date, forKey: "date")
    }
}

extension UserDefaults {
    static var shared: UserDefaults? {
        let appGroupID = "group.OurDday"
        return UserDefaults(suiteName: appGroupID)
    }
}
