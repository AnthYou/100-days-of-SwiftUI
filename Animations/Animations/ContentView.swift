//
//  ContentView.swift
//  Animations
//
//  Created by Anthony You on 04/03/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: ImplicitAnimation(),
                    label: {
                        Text("Pulse ring")
                    })
                NavigationLink(
                    destination: AnimationBindings(),
                    label: {
                        Text("Animation bindings: it works even with Bool")
                    })
                NavigationLink(
                    destination: ExplicitAnimation(),
                    label: {
                        Text("Explicit animation with 3D rotation")
                    })
                NavigationLink(
                    destination: ControllingAnimation(),
                    label: {
                        Text("Controlling animation stack")
                    })
                NavigationLink(
                    destination: GesturesBox(),
                    label: {
                        Text("Drag and drop box")
                    })
                NavigationLink(
                    destination: SneakyLetters(),
                    label: {
                        Text("Sneaky letters")
                    })
                NavigationLink(
                    destination: Transitions(),
                    label: {
                        Text("Showing and hiding views with transitions")
                    })
            }
            .navigationTitle("Animations")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
