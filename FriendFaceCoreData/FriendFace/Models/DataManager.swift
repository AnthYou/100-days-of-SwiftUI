//
//  DataManager.swift
//  FriendFace
//
//  Created by Anthony You on 11/03/2021.
//

import Foundation
import CoreData

struct DataManager {
    static func loadUsers(moc: NSManagedObjectContext) {
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let safeData = data {
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                if let decodedResponse = try? decoder.decode([JSONUser].self, from: safeData) {
                    DispatchQueue.main.async {
                        var tmpUsers = [User]()
                        
                        for user in decodedResponse {
                            let newUser = User(context: moc)
                            newUser.id = user.id
                            newUser.name = user.name
                            newUser.age = Int16(user.age)
                            newUser.address = user.address
                            newUser.registered = user.registered
                            newUser.about = user.about
                            newUser.company = user.company
                            newUser.email = user.email
                            newUser.isActive = user.isActive
                            tmpUsers.append(newUser)
                            
                            for friend in user.friends {
                                if let newFriend = tmpUsers.first(where: { $0.id == friend.id }) {
                                    newUser.addToFriends(newFriend)
                                }
                            }
                            
                        }
                        do {
                            try moc.save()
                        } catch {
                            print(error)
                        }
                    }
                    return
                }
                
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
        
    }
}
