//
//  ContentView.swift
//  AccessibilityProject
//
//  Created by Anthony You on 14/03/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: IdentifyingViews(),
                    label: {
                        Text("Identifying views with useful labels")
                    })
                NavigationLink(
                    destination: HidingGrouping(),
                    label: {
                        Text("Hiding and grouping accessibility data")
                    })
                NavigationLink(
                    destination: ReadingValueControls(),
                    label: {
                        Text("Reading the value of controls")
                    })
            }
            .navigationTitle("Accessibility")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
