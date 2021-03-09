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
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Age: \(user.age) years old")
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("About: \(user.about)")
                Text("Registered on \(formattedDate)")
                Divider()
                Text("Tags:")
                Text(formattedTags)
                Spacer()
            }
            .padding()
            .navigationBarTitle(user.name)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static let users: [User] = Bundle.main.decode("friendface.json")
    
    static var previews: some View {
        DetailView(user: users[0])
    }
}

//let id: UUID
//let isActive: Bool
//let name: String
//let age: Int
//let company: String
//let email: String
//let address: String
//let about: String
//let registered: Date
//let tags: [String]
//let friends: [Friend]
