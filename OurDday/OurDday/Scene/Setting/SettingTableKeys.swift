//
//  SettingTableKeys.swift
//  OurDday
//
//  Created by rae on 2022/08/05.
//

import Foundation

struct SettingTableKeys {
    static let Section = "section"
    static let Rows = "rows"
    static let Title = "title"
    static let SubTitle = "subTitle"
    
    static let changeDate = "우리 만난 날 설정"
    static let setPhoto = "배경 이미지 설정"
    static let resetPhoto = "배경 이미지 초기화"
    static let resetProfile = "우리 이미지 초기화"
    
    static let data: [[String:Any]] = [
        [
            SettingTableKeys.Section: "화면 설정",
            SettingTableKeys.Rows: [
                [SettingTableKeys.Title: changeDate],
                [SettingTableKeys.Title: setPhoto],
                [SettingTableKeys.Title: resetPhoto],
                [SettingTableKeys.Title: resetProfile],
            ]
        ],
    ]
}
