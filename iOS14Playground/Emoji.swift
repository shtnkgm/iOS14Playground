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
    
    static let dog = Emoji(icon: "🐶", name: "Dog", description: "I'm a cute dog! I want to go for a walk.")
    static let cat = Emoji(icon: "🐱", name: "Cat", description: "I'm a cute cat! Play with me.")
    static let pig = Emoji(icon: "🐷", name: "Pig", description: "I'm a cute pig! Give me lunch.")
}
