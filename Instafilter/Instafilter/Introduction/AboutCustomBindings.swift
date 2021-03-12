//
//  AboutCustomBindings.swift
//  Instafilter
//
//  Created by Anthony You on 11/03/2021.
//

import SwiftUI

struct AboutCustomBindings: View {
    @State private var blurAmount: CGFloat = 0
    
    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
                // If you want to save to UserDefaults, here is the place to (set closure of a Binding)
            }
        )
        return VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            Slider(value: blur, in: 0...20)
        }
    }
}

struct AboutCustomBindings_Previews: PreviewProvider {
    static var previews: some View {
        AboutCustomBindings()
    }
}
