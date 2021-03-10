//
//  ContentView.swift
//  FriendFace
//
//  Created by Anthony You on 09/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink(
                    destination: DetailView(user: user, users: users),
                    label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                            Text(user.email)
                                .foregroundColor(.secondary)
                        }
                    })
                
            }
            .navigationBarTitle("FriendFace")
            .onAppear(perform: loadUsers)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func loadUsers() {

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let safeData = data {
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                if let decodedResponse = try? decoder.decode([User].self, from: safeData) {
                    DispatchQueue.main.async {
                        self.users = decodedResponse
                    }
                    return
                }
                
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
