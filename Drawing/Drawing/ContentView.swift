//
//  ContentView.swift
//  Drawing
//
//  Created by Anthony You on 05/03/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Creating paths", destination: CustomPaths())
                NavigationLink("Creating shapes", destination: Shapes())
                NavigationLink("Transforming shapes", destination: TransformingShapes())
                NavigationLink("Border with ImagePaint", destination: BorderImagePaint())
                NavigationLink("Power of Metal", destination: MetalDemo())
                NavigationLink("Special effects", destination: SpecialEffects())
                NavigationLink("Animating simple shapes", destination: AnimatingShapes())
                NavigationLink("Animating complex shapes", destination: AnimatingComplex())
                NavigationLink("Spirograph", destination: SpirographView())
            }
            .navigationTitle("Drawing")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
