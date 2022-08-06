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
    
    static let data: [[String:Any]] = [
        [
            SettingTableKeys.Section: "화면 설정",
            SettingTableKeys.Rows: [
                [SettingTableKeys.Title: changeDate],
            ]
        ],
//        [
//            TableKeys.Rows: [
//                [TableKeys.ImageName: "fb_friends", TableKeys.Title: "Friends"],
//                [TableKeys.ImageName: "fb_events", TableKeys.Title: "Events"],
//                [TableKeys.ImageName: "fb_groups", TableKeys.Title: "Groups"],
//                [TableKeys.ImageName: "fb_education", TableKeys.Title: "Education"],
//                [TableKeys.ImageName: "fb_town_hall", TableKeys.Title: "Town Hall"],
//                [TableKeys.ImageName: "fb_games", TableKeys.Title: "Instant Games"],
//                [TableKeys.ImageName: "fb_placeholder", TableKeys.Title: TableKeys.seeMore],
//            ]
//        ],
//        [
//            TableKeys.Section: "FAVORITES",
//            TableKeys.Rows: [
//                [TableKeys.ImageName: "fb_placeholder",TableKeys.Title: TableKeys.addFavorites]
//            ]
//        ],
//        [
//            TableKeys.Rows: [
//                [TableKeys.ImageName: "fb_settings", TableKeys.Title: "Settings"],
//                [TableKeys.ImageName: "fb_privacy_shortcuts", TableKeys.Title: "Privacy Shortcuts"],
//                [TableKeys.ImageName: "fb_help_and_support", TableKeys.Title: "Help and Support"]
//            ]
//        ],
//        [
//            TableKeys.Rows: [
//                [TableKeys.Title: TableKeys.logOut]
//            ]
//        ]
    ]
}
