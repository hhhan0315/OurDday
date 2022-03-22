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
        var entry = SimpleEntry(date: Date(), backgroundImage: nil)
        
        if let url = userDefaults?.url(forKey: "imageUrl"),
           let image = UIImage(contentsOfFile: url.path){
            entry.backgroundImage = image
        }

//        let timeline = Timeline(entries: entries, policy: .never)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var backgroundImage: UIImage?
}

struct OurDdayWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
//        let userDefaults = UserDefaults(suiteName: "group.OurDday")
//
//        if let url = userDefaults?.url(forKey: "imageUrl"),
//           let image = UIImage(contentsOfFile: url.path) {
//            Image(uiImage: image).resizable().scaledToFill()
//        }
        if let backgroundImage = entry.backgroundImage {
            Image(uiImage: backgroundImage)
                .resizable()
                .scaledToFill()
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
