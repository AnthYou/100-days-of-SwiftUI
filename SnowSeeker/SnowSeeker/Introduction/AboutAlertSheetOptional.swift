//
//  AboutAlertSheetOptional.swift
//  SnowSeeker
//
//  Created by Anthony You on 15/07/2021.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct AboutAlertSheetOptional: View {
    @State private var selectedUser: User? = nil

    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                self.selectedUser = User()
            }
            .alert(item: $selectedUser) { user in
                Alert(title: Text(user.id))
            }
    }
}

// Alternative
//struct ContentView: View {
//    @State private var selectedUser: User? = nil
//    @State private var isShowingAlert = false
//
//    var body: some View {
//        Text("Hello, World!")
//            .onTapGesture {
//                self.selectedUser = User()
//                self.isShowingAlert = true
//            }
//            .alert(isPresented: $isShowingAlert) {
//                Alert(title: Text(selectedUser!.id))
//            }
//    }
//}

struct AboutAlertSheetOptional_Previews: PreviewProvider {
    static var previews: some View {
        AboutAlertSheetOptional()
    }
}
