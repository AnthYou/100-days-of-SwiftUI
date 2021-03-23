//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Anthony You on 23/03/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("How layout works in SwiftUI", destination: AboutLayout())
                NavigationLink("Alignment and alignment guides", destination: AboutAlignment())
                NavigationLink("How to create a custom aligment guide", destination: AboutCustomAlignmentGuide())
                NavigationLink("Absolute positioning for SwiftUI views", destination: AboutAbsolutePositioning())
                NavigationLink("Understanding frames and coordinates inside GeometryReader", destination: AboutFramesCoordinates())
                NavigationLink("ScrollView effects using GeometryReader (vertical)", destination: AboutScrollViewEffects())
                NavigationLink("ScrollView effects using GeometryReader (horizontal)", destination: AboutScrollViewEffects2())
            }
            .navigationBarTitle("Layout and geometry")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
