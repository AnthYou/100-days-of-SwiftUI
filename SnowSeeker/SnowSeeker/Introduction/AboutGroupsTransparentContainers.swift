//
//  AboutGroupsTransparentContainers.swift
//  SnowSeeker
//
//  Created by Anthony You on 15/07/2021.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

//struct AboutGroupsTransparentContainers: View {
//    @State private var layoutVertically = false
//
//    var body: some View {
//        Group {
//            if layoutVertically {
//                VStack {
//                    UserView()
//                }
//            } else {
//                HStack {
//                    UserView()
//                }
//            }
//        }
//        .onTapGesture {
//            self.layoutVertically.toggle()
//        }
//    }
//}

struct AboutGroupsTransparentContainers: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        Group {
//            if sizeClass == .compact {
//                VStack {
//                    UserView()
//                }
//            } else {
//                HStack {
//                    UserView()
//                }
//            }
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}

struct AboutGroupsTransparentContainers_Previews: PreviewProvider {
    static var previews: some View {
        AboutGroupsTransparentContainers()
    }
}
