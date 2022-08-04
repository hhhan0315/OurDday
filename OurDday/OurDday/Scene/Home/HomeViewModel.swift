//
//  HomeViewModel.swift
//  OurDday
//
//  Created by rae on 2022/04/01.
//

import Foundation

class HomeViewModel: NSObject {
    private let storage = LocalStorageManager.shared
    
    private var homeUser = User.EMPTY
    
    func user() -> User {
        return homeUser
    }
    
    func updateUser() {
        storage.updateUser { user in
            self.homeUser = user
        }
    }
    
}
