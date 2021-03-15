//
//  UsersViewModel.swift
//  RememberMe
//
//  Created by Anthony You on 14/03/2021.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var users: [User]
    
    init() {
        self.users = [User]()
    }
}
