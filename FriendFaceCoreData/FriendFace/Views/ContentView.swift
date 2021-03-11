//
//  ContentView.swift
//  FriendFace
//
//  Created by Anthony You on 09/03/2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(
                    destination: DetailView(user: user).environment(\.managedObjectContext, moc),
                    label: {
                        VStack(alignment: .leading) {
                            Text(user.unwrappedName)
                            Text(user.unwrappedEmail)
                                .foregroundColor(.secondary)
                        }
                    })
                
            }
            .navigationBarTitle("FriendFace")
            .onAppear(perform: checkDataLoad)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func checkDataLoad() {
        if users.isEmpty {
            DataManager.loadUsers(moc: moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.preview
        ContentView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
