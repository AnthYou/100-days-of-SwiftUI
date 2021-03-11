//
//  JSONUser.swift
//  FriendFace
//
//  Created by Anthony You on 10/03/2021.
//

import Foundation

struct JSONUser: Identifiable, Codable {
    let id: UUID
    let name: String
    let address: String
    let age: Int
    let isActive: Bool
    let company: String
    let email: String
    let about: String
    let registered: Date
    let friends: [JSONFriend]
}
