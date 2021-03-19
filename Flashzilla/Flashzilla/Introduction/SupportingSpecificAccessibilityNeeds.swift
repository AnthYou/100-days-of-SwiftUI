//
//  SupportingSpecificAccessibilityNeeds.swift
//  Flashzilla
//
//  Created by Anthony You on 19/03/2021.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct SupportingSpecificAccessibilityNeeds: View {
    // Differenciate without color
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    // Reduce motion
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale: CGFloat = 1
    
    // Reduce transparency
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    var body: some View {
        VStack {
            // Differenciate without color
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                
                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? Color.black : Color.green)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            
            // Reduce motion
//            Text("Hello, World!")
//                .scaleEffect(scale)
//                .onTapGesture {
//                    if self.reduceMotion {
//                        self.scale *= 1.5
//                    } else {
//                        withAnimation {
//                            self.scale *= 1.5
//                        }
//                    }
//                }
            
            // We can use for reducing motion thanks to the func withOptionalAnimation
            Text("Hello, World!")
                .scaleEffect(scale)
                .onTapGesture {
                    withOptionalAnimation {
                        self.scale *= 1.5
                    }
                }
            
            // Reduce transparency
            Text("Hello, World!")
                .padding()
                .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
                .foregroundColor(Color.white)
                .clipShape(Capsule())
        }
    }
}

struct SupportingSpecificAccessibilityNeeds_Previews: PreviewProvider {
    static var previews: some View {
        SupportingSpecificAccessibilityNeeds()
    }
}
