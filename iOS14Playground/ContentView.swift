//
//  ContentView.swift
//  iOS14Playground
//
//  Created by Shota Nakagami on 2020/07/13.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.com.shotanakagami.iOS14Playground")) var emojiData: Data = Data()
    
    let emojis: [Emoji] =  [.dog, .cat, .pig]
    
    var body: some View {
        VStack(spacing: 30) {
            ForEach(emojis) { emoji in
                EmojiView(emoji: emoji)
                    .onTapGesture {
                        save(emoji)
                    }
            }
        }
    }
    
    func save(_ emoji: Emoji) {
        guard let emojiData = try? JSONEncoder().encode(emoji) else {
            return
        }
        self.emojiData = emojiData
        print("save \(emoji)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
