//
//  LocalStorageManager.swift
//  OurDday
//
//  Created by rae on 2022/02/17.
//

import UIKit

class LocalStorageManager {
    static let shared = LocalStorageManager()
    
    private let userDefaults: UserDefaults?
    
    private init() {
        self.userDefaults = UserDefaults.shared
    }
    
    func isFirstLaunch() -> Bool {
        if userDefaults?.object(forKey: "isFirstLaunch") == nil {
            return true
        } else {
            return false
        }
    }
    
    func setFirstLaunch() {
        userDefaults?.set("No", forKey: "isFirstLaunch")
    }
    
    func setImageUrl(url: URL) {
        userDefaults?.set(url, forKey: "imageUrl")
    }
    
    func setDate(date: Date) {
        userDefaults?.set(date, forKey: "date")
    }
    
    func readImageUrl() -> URL? {
        return userDefaults?.url(forKey: "imageUrl")
    }
    
    func readDate() -> Date {
        if let date = userDefaults?.object(forKey: "date") as? Date {
            return date
        } else {
            return Date()
        }
    }
    
    func updateHomeInformation(completion: @escaping (HomeInformation) -> Void) {
        var home = HomeInformation.EMPTY
//        home.imageUrl = readImageUrl()
        home.date = readDate()
        completion(home)
    }
}

extension UserDefaults {
    static var shared: UserDefaults? {
        let appGroupID = "group.OurDday"
        return UserDefaults(suiteName: appGroupID)
    }
}
