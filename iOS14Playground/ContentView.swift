//
//  ContentView.swift
//  iOS14Playground
//
//  Created by Shota Nakagami on 2020/07/13.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.com.shotanakagami.iOS14Playground")) var emojiData: Data = Data()
    
    let emojis: [Emoji] =  [
        .init(icon: "🐶", name: "Dog", description: "I'm a cute dog! I want to go for a walk."),
        .init(icon: "🐱", name: "Cat", description: "I'm a cute cat! Play with me."),
        .init(icon: "🐷", name: "Pig", description: "I'm a cute pig! Give me lunch.")
    ]
    
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
