//
//  LocalStorage.swift
//  OurDday
//
//  Created by rae on 2022/02/17.
//

import UIKit

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
    
    func setPhrases(phrases: String) {
        defaults?.set(phrases, forKey: "phrases")
    }
    
    func readImageUrl() -> URL? {
        return defaults?.url(forKey: "imageUrl")
    }
    
    func readFirstDate() -> Date {
        if let date = defaults?.object(forKey: "date") as? Date {
            return date
        } else {
            return Date()
        }
    }
    
    func readPhrases() -> String {
        return defaults?.string(forKey: "phrases") ?? ""
    }
    
    func updateUser(completion: @escaping (User) -> Void) {
        var user = User.EMPTY
        user.imageUrl = readImageUrl()
        user.date = readFirstDate()
        user.phrases = readPhrases()
        completion(user)
    }
    
    func colorForKey(key: String = "mainColor") -> UIColor? {
          var colorReturnded: UIColor? = UIColor.systemBlue
          if let colorData = defaults?.data(forKey: key) {
              do {
                  if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
                      colorReturnded = color
                  }
              } catch {
                  print("Error UserDefaults")
              }
          }
          return colorReturnded
      }

      func setColor(color: UIColor?, forKey key: String = "mainColor") {
          var colorData: NSData?
          if let color = color {
              do {
                  let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
                  colorData = data
              } catch {
                  print("Error UserDefaults")
              }
          }
          defaults?.set(colorData, forKey: key)
      }
}

extension UserDefaults {
    static var shared: UserDefaults? {
        let appGroupID = "group.OurDday"
        return UserDefaults(suiteName: appGroupID)
    }
}
