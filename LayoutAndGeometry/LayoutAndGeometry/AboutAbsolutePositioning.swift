//
//  AboutAbsolutePositioning.swift
//  LayoutAndGeometry
//
//  Created by Anthony You on 23/03/2021.
//

import SwiftUI

struct AboutAbsolutePositioning: View {
    @State private var usingPosition = false
    
    var body: some View {
        VStack {
            Toggle("Switch to \( usingPosition ? "offset" : "position" )", isOn: $usingPosition)
                .padding()
            
            if usingPosition {
                Text("Hello, world!")
                    .position(x: 100, y: 100)
                    .background(Color.red)
            } else {
                Text("Hello, world!")
                    .offset(x: 100, y: 100)
                    .background(Color.red)
            }
            
        }
        
    }
}

struct AboutAbsolutePositioning_Previews: PreviewProvider {
    static var previews: some View {
        AboutAbsolutePositioning()
    }
}
