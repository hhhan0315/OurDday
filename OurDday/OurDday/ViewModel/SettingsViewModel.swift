//
//  SettingsViewModel.swift
//  OurDday
//
//  Created by rae on 2022/03/01.
//

import Foundation

struct SettingsViewModel {
    private let settings: [Setting] = [
        Setting(iconName: "calendar", title: "기념일 설정"),
//        Setting(iconName: "trash", title: "지난 일정 삭제"),
    ]
    
    func settingsCount() -> Int {
        return settings.count
    }
    
    func setting(at index: Int) -> Setting {
        return settings[index]
    }
}
