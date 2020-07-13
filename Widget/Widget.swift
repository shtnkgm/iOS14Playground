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
        let timeline = Timeline(entries: [entry], policy: .never)
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
    
    var body: some View {
        EmojiView(emoji: entry.emoji)
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
        }
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
