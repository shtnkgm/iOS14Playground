//
//  Widget.swift
//  Widget
//
//  Created by Shota Nakagami on 2020/07/13.
//

import WidgetKit
import SwiftUI

struct EmojiEntry: TimelineEntry {
    var date = Date()
    let emoji: Emoji
}

struct Provider: TimelineProvider {
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.com.shotanakagami.iOS14Playground")) var emojiData: Data = Data()
    
    func snapshot(with context: Context, completion: @escaping (EmojiEntry) -> ()) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else { return }
        let entry = EmojiEntry(emoji: emoji)
        completion(entry)
    }
    
    func timeline(with context: Context, completion: @escaping (Timeline<EmojiEntry>) -> ()) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else { return }
        let entry = EmojiEntry(emoji: emoji)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct PlaceholderView: View {
    var body: some View {
        EmojiView(emoji: .init(icon: "🍙", name: "-", description: "-"))
    }
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            EmojiView(emoji: entry.emoji)
            
        case .systemMedium:
            HStack(spacing: 30) {
                EmojiView(emoji: entry.emoji)
                Text(entry.emoji.name)
                    .font(.largeTitle)
            }
            
        case .systemLarge:
            VStack(spacing: 30) {
                HStack(spacing: 30) {
                    EmojiView(emoji: entry.emoji)
                    Text(entry.emoji.name)
                        .font(.largeTitle)
                }
                Text(entry.emoji.description)
                    .font(.title2)
                    .padding()
            }
            
        default:
            EmojiView(emoji: entry.emoji)
        }
    }
}

@main
struct MyWidget: Widget {
    private let kind = "MyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider(),
            placeholder: PlaceholderView()
        ) { entry in
            WidgetEntryView(entry: entry)
        }.supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: .init(emoji: .init(icon: "🐶", name: "Dog", description: "I'm a cute dog! I want to go for a walk."))).previewLayout(.sizeThatFits)
    }
}
