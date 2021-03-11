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
        return formatter.string(from: user.unwrappedRegistered)
    }
        
    var body: some View {
        List {
            Section(header: Text("Personal info")) {
                Text("Age: \(user.age) years old")
                Text("Company: \(user.unwrappedCompany)")
                Text("Email: \(user.unwrappedEmail)")
                Text("Address: \(user.unwrappedAddress)")
            }
            Section(header: Text("Description")) {
                Text(user.unwrappedAbout)
            }
            Section(header: Text("Registered on")) {
                Text(formattedDate)
            }
            Section(header: Text("Friends")) {
                ForEach(user.friendsArray, id: \.id) { friend in
                    NavigationLink(
                        destination: DetailView(user: friend),
                        label: {
                            VStack(alignment: .leading) {
                                Text(friend.unwrappedName)
                                Text(friend.unwrappedEmail)
                                    .foregroundColor(.secondary)
                            }
                        })
                }
            }
        }
        .navigationBarTitle(user.unwrappedName)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DetailView_Previews: PreviewProvider {
    static var tim: User {
        let user = User()
        user.name = "Tim Cook"
        user.age = 50
        user.registered = Date()
        user.email = "timcook@apple.com"
        user.address = "Cupertino"
        user.company = "Apple"
        
        return user
    }
    
    static var previews: some View {
        DetailView(user: tim)
    }
}
