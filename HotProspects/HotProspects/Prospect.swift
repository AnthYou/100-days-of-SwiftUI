//
//  Prospect.swift
//  HotProspects
//
//  Created by Anthony You on 17/03/2021.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    var date = Date()
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"

    init() {
        // Loading data through UserDefaults
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                self.people = decoded
//                return
//            }
//        }
//        self.people = []
        
        // Loading data through documentDirectory
        self.people = []
        
        if let data = loadData() {
            if let decodedPeople = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decodedPeople
                return
            }
        }
    }
    
    // MARK: Loading and saving data through documentDirectory
    private func loadData() -> Data? {
        let url = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }
    
    private func saveData() {
        let url = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        
        if let data = try? JSONEncoder().encode(people) {
            do {
                try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func save() {
        // Saving data through UserDefaults
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        // save()
        saveData()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        // save()
        saveData()
    }
}
