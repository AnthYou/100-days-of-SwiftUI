//
//  DetailView.swift
//  FriendFace
//
//  Created by Anthony You on 09/03/2021.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: user.registered)
    }
    
    var formattedTags: String {
        return user.tags.joined(separator: ", ")
    }
    
    var users: [User]
        
    var body: some View {
        List {
            Section(header: Text("Personal info")) {
                Text("Age: \(user.age) years old")
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
            }
            Section(header: Text("Description")) {
                Text(user.about)
            }
            Section(header: Text("Registered on")) {
                Text(formattedDate)
            }
            Section(header: Text("Tags")) {
                Text(formattedTags)
            }
            Section(header: Text("Friends")) {
                ForEach(user.friends) { friend in
                    NavigationLink(
                        destination: DetailView(user: getUserby(id: friend.id) ?? user, users: users),
                        label: {
                            VStack(alignment: .leading) {
                                Text(friend.name)
                                Text(getUserby(id: friend.id)?.email ?? "")
                                    .foregroundColor(.secondary)
                            }
                        })
                }
            }
        }
        .navigationBarTitle(user.name)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getUserby(id: UUID) -> User? {
        return users.first(where: { $0.id == id })
    }
}

struct DetailView_Previews: PreviewProvider {
    static let users: [User] = Bundle.main.decode("friendface.json")
    
    static var previews: some View {
        DetailView(user: users[0], users: users)
    }
}
