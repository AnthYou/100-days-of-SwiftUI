//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Anthony You on 08/03/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("About self", destination: AboutSelf())
                NavigationLink("About has changed", destination: AboutHasChanged())
                NavigationLink("About duplicates", destination: AboutDuplicates())
                NavigationLink("About NSPredicate", destination: AboutNSPredicate())
                NavigationLink("Dynamic filtering", destination: AboutDynamicFiltering())
                NavigationLink("About one to many relationship", destination: AboutOneToMany())
            }
            .navigationTitle("Core Data deep dive")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
