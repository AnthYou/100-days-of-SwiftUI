//
//  MainView.swift
//  RememberMe
//
//  Created by Anthony You on 14/03/2021.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var usersViewModel = UsersViewModel()
    @State private var isAddingUser = false
    
    var body: some View {
        NavigationView {
            List(usersViewModel.users.sorted()) { user in
                NavigationLink(
                    destination: DetailView(user: user),
                    label: {
                        HStack {
                            Image(uiImage: user.loadPhoto(with: user.photo) ?? UIImage(imageLiteralResourceName: "Example"))
                                .resizable()
                                .scaledToFit()
                                .clipped()
                                .frame(width: 100, height: 100, alignment: .leading)
                                .padding(.trailing)
                            Text(user.name)
                        }
                    })
            }
            .sheet(isPresented: $isAddingUser, onDismiss: saveData, content: {
                AddView(usersViewModel: usersViewModel)
            })
            .navigationTitle("RememberMe")
            .navigationBarItems(trailing: Button(action: {
                self.isAddingUser = true
            }, label: {
                Image(systemName: "plus")
                Text("Add")
            }))
            .onAppear(perform: loadData)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: Data Management
    
    func loadData() {
        let filename = FileManager.default.getDocumentsDirectory().appendingPathComponent("SavedUsers")

        do {
            let data = try Data(contentsOf: filename)
            usersViewModel.users = try JSONDecoder().decode([User].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = FileManager.default.getDocumentsDirectory().appendingPathComponent("SavedUsers")
            let data = try JSONEncoder().encode(usersViewModel.users)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
