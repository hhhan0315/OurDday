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
    
    func setDate(date: Date) {
        userDefaults?.set(date, forKey: "date")
    }
    
    func readDate() -> Date {
        if let date = userDefaults?.object(forKey: "date") as? Date {
            return date
        } else {
            return Date()
        }
    }
    
    func setPhotoURL(url: URL) {
        userDefaults?.set(url, forKey: "photoURL")
    }
    
    func readPhotoURL() -> URL? {
        return userDefaults?.url(forKey: "photoURL")
    }
    
    func setProfileFirstURL(url: URL) {
        userDefaults?.set(url, forKey: "profileFirstURL")
    }
    
    func readProfileFirstURL() -> URL? {
        return userDefaults?.url(forKey: "profileFirstURL")
    }
    
    func setProfileSecondURL(url: URL) {
        userDefaults?.set(url, forKey: "profileSecondURL")
    }
    
    func readProfileSecondURL() -> URL? {
        return userDefaults?.url(forKey: "profileSecondURL")
    }
    
    func updateHomeInformation(completion: @escaping (HomeInformation) -> Void) {
        var home = HomeInformation.EMPTY
        home.photoURL = readPhotoURL()
        home.profileFirstURL = readProfileFirstURL()
        home.profileSecondURL = readProfileSecondURL()
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
