//
//  AboutCustomEnvironment.swift
//  HotProspects
//
//  Created by Anthony You on 17/03/2021.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

// MARK: Views

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

// MARK: Main View

struct AboutCustomEnvironment: View {
    let user = User()

    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct AboutCustomEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        AboutCustomEnvironment()
    }
}
