//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Anthony You on 16/07/2021.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>

    private let saveKey = "Favorites"

    init() {
        // load our saved data

        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedData = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decodedData
                return
            }
        }

        self.resorts = []
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data

        if let encodedData = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }

}
