//
//  Card.swift
//  Flashzilla
//
//  Created by Anthony You on 19/03/2021.
//

import Foundation

struct Card: Identifiable, Codable {
    let id: UUID
    let prompt: String
    let answer: String

    static var example: Card {
        Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
