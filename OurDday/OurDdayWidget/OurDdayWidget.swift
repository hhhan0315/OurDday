//
//  OurDdayWidget.swift
//  OurDdayWidget
//
//  Created by rae on 2022/03/17.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.OurDday")
        var entry = SimpleEntry(date: Date())
        
        if let url = userDefaults?.url(forKey: "photoURL"),
           let image = UIImage(contentsOfFile: url.path) {
            entry.backgroundImage = image
        } else {
            entry.backgroundImage = UIImage(named: "photo")
        }
        
        if let url = userDefaults?.url(forKey: "profileFirstURL"),
           let image = UIImage(contentsOfFile: url.path) {
            entry.profileFirstImage = image
        } else {
            entry.profileFirstImage = UIImage(named: "smile")
        }
        
        if let url = userDefaults?.url(forKey: "profileSecondURL"),
           let image = UIImage(contentsOfFile: url.path) {
            entry.profileSecondImage = image
        } else {
            entry.profileSecondImage = UIImage(named: "smile")
        }
        
        if let date = userDefaults?.object(forKey: "date") as? Date {
            let calendar = Calendar.current
            
            let from = calendar.startOfDay(for: date)
            let to = calendar.startOfDay(for: Date())
            
            let components = calendar.dateComponents([.day], from: from, to: to)
            let dayCount = components.day ?? 0
            
            entry.todayCount = dayCount
        }
        
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let startOfDay = Calendar.current.startOfDay(for: currentDate)
        
        let userDefaults = UserDefaults(suiteName: "group.OurDday")
        var entry = SimpleEntry(date: startOfDay)
        
        if let url = userDefaults?.url(forKey: "photoURL"),
           let image = UIImage(contentsOfFile: url.path) {
            entry.backgroundImage = image
        } else {
            entry.backgroundImage = UIImage(named: "photo")
        }
        
        if let url = userDefaults?.url(forKey: "profileFirstURL"),
           let image = UIImage(contentsOfFile: url.path) {
            entry.profileFirstImage = image
        } else {
            entry.profileFirstImage = UIImage(named: "smile")
        }
        
        if let url = userDefaults?.url(forKey: "profileSecondURL"),
           let image = UIImage(contentsOfFile: url.path) {
            entry.profileSecondImage = image
        } else {
            entry.profileSecondImage = UIImage(named: "smile")
        }
        
        if let date = userDefaults?.object(forKey: "date") as? Date {
            let calendar = Calendar.current
            
            let from = calendar.startOfDay(for: date)
            let to = calendar.startOfDay(for: Date())
            
            let components = calendar.dateComponents([.day], from: from, to: to)
            let dayCount = components.day ?? 0
            
            entry.todayCount = dayCount
        }
        
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)
        let timeline = Timeline(entries: [entry], policy: .after(endOfDay ?? Date()))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var backgroundImage: UIImage?
    var todayCount: Int?
    var profileFirstImage: UIImage?
    var profileSecondImage: UIImage?
}

struct OurDdayWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall, .systemLarge:
            let size = widgetHeight(forFamily: family)
            let dayCountFontSize = widgetDayCountFontSize(forFamily: family)
            
            if let backgroundImage = entry.backgroundImage {
                ZStack {
                    Image(uiImage: backgroundImage)
                        .resizable()
                        .scaledToFill()
                    
                    if let todayCount = entry.todayCount {
                        Text(String(todayCount + 1) + "일")
                            .font(Font.custom("BMJUA", size: dayCountFontSize))
                            .foregroundColor(.white)
                            .frame(width: size.width - 20, height: size.height - 20, alignment: .bottomTrailing)
                    }
                }
            }
        case .systemMedium:
            let dayCountFontSize = widgetDayCountFontSize(forFamily: family)
            
            if let profileFirstImage = entry.profileFirstImage,
               let profileSecondImage = entry.profileSecondImage,
               let heartImage = UIImage(systemName: "heart.fill") {
                HStack {
                    Image(uiImage: profileFirstImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                    VStack {
                        Image(uiImage: heartImage)
                            .renderingMode(.template)
                            .foregroundColor(Color.init("WidgetColor"))
                        if let todayCount = entry.todayCount {
                            Text(String(todayCount + 1) + "일")
                                .font(Font.custom("BMJUA", size: dayCountFontSize))
                                .foregroundColor(.black)
                        }
                    }
                    Image(uiImage: profileSecondImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                }
            }
        default:
            EmptyView()
        }
    }
    
    
    @main
    struct OurDdayWidget: Widget {
        let kind: String = "OurDdayWidget"
        
        var body: some WidgetConfiguration {
            StaticConfiguration(kind: kind, provider: Provider()) { entry in
                OurDdayWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("우리디데이 위젯")
            .description("우리디데이를 위젯으로 확인할 수 있습니다.")
        }
    }
    
    func widgetHeight(forFamily family:WidgetFamily) -> CGSize {
        // better to use getTimeline func context.displaySize before this one.
        
        switch family {
        case .systemSmall:
            switch UIScreen.main.bounds.size {
            case CGSize(width: 428, height: 926):   return CGSize(width:170, height: 170)
            case CGSize(width: 414, height: 896):   return CGSize(width:169, height: 169)
            case CGSize(width: 414, height: 736):   return CGSize(width:159, height: 159)
            case CGSize(width: 390, height: 844):   return CGSize(width:158, height: 158)
            case CGSize(width: 375, height: 812):   return CGSize(width:155, height: 155)
            case CGSize(width: 375, height: 667):   return CGSize(width:148, height: 148)
            case CGSize(width: 360, height: 780):   return CGSize(width:155, height: 155)
            case CGSize(width: 320, height: 568):   return CGSize(width:141, height: 141)
            default:                                return CGSize(width:155, height: 155)
            }
        case .systemMedium:
            switch UIScreen.main.bounds.size {
            case CGSize(width: 428, height: 926):   return CGSize(width:364, height: 170)
            case CGSize(width: 414, height: 896):   return CGSize(width:360, height: 169)
            case CGSize(width: 414, height: 736):   return CGSize(width:348, height: 159)
            case CGSize(width: 390, height: 844):   return CGSize(width:338, height: 158)
            case CGSize(width: 375, height: 812):   return CGSize(width:329, height: 155)
            case CGSize(width: 375, height: 667):   return CGSize(width:321, height: 148)
            case CGSize(width: 360, height: 780):   return CGSize(width:329, height: 155)
            case CGSize(width: 320, height: 568):   return CGSize(width:292, height: 141)
            default:                                return CGSize(width:329, height: 155)
            }
        case .systemLarge:
            switch UIScreen.main.bounds.size {
            case CGSize(width: 428, height: 926):   return CGSize(width:364, height: 382)
            case CGSize(width: 414, height: 896):   return CGSize(width:360, height: 379)
            case CGSize(width: 414, height: 736):   return CGSize(width:348, height: 357)
            case CGSize(width: 390, height: 844):   return CGSize(width:338, height: 354)
            case CGSize(width: 375, height: 812):   return CGSize(width:329, height: 345)
            case CGSize(width: 375, height: 667):   return CGSize(width:321, height: 324)
            case CGSize(width: 360, height: 780):   return CGSize(width:329, height: 345)
            case CGSize(width: 320, height: 568):   return CGSize(width:292, height: 311)
            default:                                return CGSize(width:329, height: 345)
            }
            
        default:                                return CGSize(width:329, height: 345)
        }
    }
    
    func widgetDayCountFontSize(forFamily family: WidgetFamily) -> CGFloat {
        switch family {
        case .systemSmall: return CGFloat(30.0)
        case .systemMedium: return CGFloat(20.0)
        case .systemLarge: return CGFloat(50.0)
        default: return CGFloat(48.0)
        }
    }
    
}
//struct OurDdayWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            OurDdayWidgetEntryView(entry: SimpleEntry(date: Date()))
//                .previewContext(WidgetPreviewContext(family: .systemSmall))
//            OurDdayWidgetEntryView(entry: SimpleEntry(date: Date()))
//                .previewContext(WidgetPreviewContext(family: .systemSmall))
//        }
//    }
//}
