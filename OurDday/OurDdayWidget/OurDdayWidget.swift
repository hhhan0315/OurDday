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
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
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
        
//        let timeline = Timeline(entries: entries, policy: .never)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var backgroundImage: UIImage?
    var todayCount: Int?
}

struct OurDdayWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        if let backgroundImage = entry.backgroundImage {
            ZStack {
                Image(uiImage: backgroundImage)
                    .resizable()
                    .scaledToFill()
                
                if let todayCount = entry.todayCount {
                    Text("\(todayCount + 1)일")
                        .foregroundColor(.white)
                        .font(.system(size: 32.0, weight: .semibold, design: .default))
                }
            }
        } else {
            ZStack {
                if let todayCount = entry.todayCount {
                    let color = Color(UIColor(red: 0.910, green: 0.478, blue: 0.643, alpha: 1.0))
                    Text("\(todayCount + 1)일")
                        .foregroundColor(color)
                        .font(.system(size: 32.0, weight: .semibold, design: .default))
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
