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
        var entry = SimpleEntry(date: Date(), backgroundImage: nil, todayCount: nil)

        if let url = userDefaults?.url(forKey: "imageUrl"),
           let image = UIImage(contentsOfFile: url.path){
            entry.backgroundImage = image
        }

        if let date = userDefaults?.object(forKey: "date") as? Date {
            let calendar = Calendar.current

            let from = calendar.startOfDay(for: date)
            let to = calendar.startOfDay(for: Date())

            let components = calendar.dateComponents([.day], from: from, to: to)
            let dayCount = components.day ?? 0

            entry.todayCount = dayCount
        }
        
        if let phrases = userDefaults?.string(forKey: "phrases") {
            entry.phrases = phrases
        }

        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let startOfDay = Calendar.current.startOfDay(for: currentDate)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let userDefaults = UserDefaults(suiteName: "group.OurDday")
        var entry = SimpleEntry(date: startOfDay, backgroundImage: nil, todayCount: nil, phrases: nil)
        
        if let url = userDefaults?.url(forKey: "imageUrl"),
           let image = UIImage(contentsOfFile: url.path){
            entry.backgroundImage = image
        }
        
        if let date = userDefaults?.object(forKey: "date") as? Date {
            let calendar = Calendar.current
            
            let from = calendar.startOfDay(for: date)
            let to = calendar.startOfDay(for: Date())
            
            let components = calendar.dateComponents([.day], from: from, to: to)
            let dayCount = components.day ?? 0
            
            entry.todayCount = dayCount
        }
        
        if let phrases = userDefaults?.string(forKey: "phrases") {
            entry.phrases = phrases
        }
        
        let timeline = Timeline(entries: [entry], policy: .after(endOfDay))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var backgroundImage: UIImage?
    var todayCount: Int?
    var phrases: String?
}

struct OurDdayWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    
    var body: some View {
        let size = widgetHeight(forFamily: family)
        let dayCountFontSize = widgetDayCountFontSize(forFamily: family)
        let phrasesFontSize = widgetPhrasesFontSize(forFamily: family)
        
        if let backgroundImage = entry.backgroundImage {
            ZStack {
                Image(uiImage: backgroundImage)
                    .resizable()
                    .scaledToFill()
                
                if let todayCount = entry.todayCount {
                    Text("\(todayCount + 1)일")
                        .foregroundColor(.white)
                        .font(.system(size: dayCountFontSize, weight: .semibold, design: .default))
                        .frame(width: size.width - 20, height: size.height - 20, alignment: .bottomTrailing)
                }
                
                if let phrases = entry.phrases {
                    Text(phrases)
                        .foregroundColor(.white)
                        .font(.system(size: phrasesFontSize, weight: .regular, design: .default))
                        .frame(width: size.width - 30, height: size.height - 30, alignment: .topLeading)
                }
            }
        } else {
            ZStack {
                if let todayCount = entry.todayCount {
                    let color = Color(UIColor(red: 0.910, green: 0.478, blue: 0.643, alpha: 1.0))
                    Text("\(todayCount + 1)일")
                        .foregroundColor(color)
                        .font(.system(size: dayCountFontSize, weight: .semibold, design: .default))
                        .frame(width: size.width - 20, height: size.height - 20, alignment: .bottomTrailing)
                }
                
                if let phrases = entry.phrases {
                    Text(phrases)
                        .foregroundColor(.black)
                        .font(.system(size: phrasesFontSize, weight: .light, design: .default))
                        .frame(width: size.width - 30, height: size.height - 30, alignment: .topLeading)
                }
            }
        }
    }
}


@main
struct OurDdayWidget: Widget {
    let kind: String = "OurDdayWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            OurDdayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("우리만의 디데이 위젯")
        .description("우리만의 디데이를 위젯으로 확인할 수 있습니다.")
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
    case .systemSmall: return CGFloat(32.0)
    case .systemMedium: return CGFloat(32.0)
    case .systemLarge: return CGFloat(48.0)
    default: return CGFloat(48.0)
    }
}

func widgetPhrasesFontSize(forFamily family: WidgetFamily) -> CGFloat {
    switch family {
    case .systemSmall: return CGFloat(18.0)
    case .systemMedium: return CGFloat(18.0)
    case .systemLarge: return CGFloat(28.0)
    default: return CGFloat(28.0)
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
