//
//  SettingsCellViewModel.swift
//  OurDday
//
//  Created by rae on 2022/03/01.
//

import Foundation

struct SettingsCellViewModel {
    let setting: Setting
    
    var title: String {
        return setting.title
    }
    
    var iconName: String {
        return setting.iconName
    }
}
