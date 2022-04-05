//
//  SideMenuViewModel.swift
//  OurDday
//
//  Created by rae on 2022/04/01.
//

import Foundation

class SideMenuViewModel: NSObject {
    private var settings = ["기념일 설정", "문구 설정", "배경화면 설정", "배경화면 사용 안함", "색상 변경"]
    
    func settingsCount() -> Int {
        return settings.count
    }

    func setting(at index: Int) -> String {
        return settings[index]
    }
}
