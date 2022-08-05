//
//  HomeViewModel.swift
//  OurDday
//
//  Created by rae on 2022/04/01.
//

import Foundation

class HomeViewModel {
    @Published var homeInformation: HomeInformation
    
    init() {
        self.homeInformation = .EMPTY
    }
    
    func fetch() {
        LocalStorageManager.shared.updateHomeInformation { homeInformation in
            self.homeInformation = homeInformation
        }
    }
}
