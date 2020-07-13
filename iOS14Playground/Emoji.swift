//
//  Emoji.swift
//  iOS14Playground
//
//  Created by Shota Nakagami on 2020/07/13.
//

import Foundation

struct Emoji: Identifiable, Codable {
    let icon: String
    let name: String
    let description: String
    
    var id: String { icon }
}
