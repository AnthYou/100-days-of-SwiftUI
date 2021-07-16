//
//  AboutTwoSidesView.swift
//  SnowSeeker
//
//  Created by Anthony You on 15/07/2021.
//

import SwiftUI

struct AboutTwoSidesView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("New secondary")) {
                Text("Hello, World!")
            }
            .navigationBarTitle("Primary")

            Text("Secondary")
        }
    }
}

struct AboutTwoSidesView_Previews: PreviewProvider {
    static var previews: some View {
        AboutTwoSidesView()
    }
}
