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
    
    func setPhrases(phrases: String) {
        userDefaults?.set(phrases, forKey: "phrases")
    }
    
    func readImageUrl() -> URL? {
        return userDefaults?.url(forKey: "imageUrl")
    }
    
    func readFirstDate() -> Date {
        if let date = userDefaults?.object(forKey: "date") as? Date {
            return date
        } else {
            return Date()
        }
    }
    
    func readPhrases() -> String {
        return userDefaults?.string(forKey: "phrases") ?? ""
    }
    
    func updateUser(completion: @escaping (User) -> Void) {
        var user = User.EMPTY
        user.imageUrl = readImageUrl()
        user.date = readFirstDate()
        user.phrases = readPhrases()
        completion(user)
    }
    
//    func colorForKey(key: String = "mainColor") -> UIColor? {
//        var colorReturnded: UIColor? = UIColor.systemBlue
//          if let colorData = userDefaults?.data(forKey: key) {
//              do {
//                  if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
//                      colorReturnded = color
//                  }
//              } catch {
//                  print("Error UserDefaults")
//              }
//          }
//          return colorReturnded
//      }
//
//      func setColor(color: UIColor?, forKey key: String = "mainColor") {
//          var colorData: NSData?
//          if let color = color {
//              do {
//                  let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
//                  colorData = data
//              } catch {
//                  print("Error UserDefaults")
//              }
//          }
//          userDefaults?.set(colorData, forKey: key)
//      }
}

extension UserDefaults {
    static var shared: UserDefaults? {
        let appGroupID = "group.OurDday"
        return UserDefaults(suiteName: appGroupID)
    }
}
