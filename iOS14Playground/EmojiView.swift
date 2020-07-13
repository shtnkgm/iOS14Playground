//
//  EmojiView.swift
//  iOS14Playground
//
//  Created by Shota Nakagami on 2020/07/13.
//

import SwiftUI

struct EmojiView: View {
    let emoji: Emoji
    
    var body: some View {
        Text(emoji.icon)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Circle())
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmojiView(emoji: .dog)
                .previewLayout(.sizeThatFits)
        }
    }
}
