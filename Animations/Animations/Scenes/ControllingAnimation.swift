//
//  ControllingAnimation.swift
//  Animations
//
//  Created by Anthony You on 04/03/2021.
//

import SwiftUI

struct ControllingAnimation: View {
    @State private var enabled = false
    
    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.red)
        .animation(nil)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

struct ControllingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ControllingAnimation()
    }
}
