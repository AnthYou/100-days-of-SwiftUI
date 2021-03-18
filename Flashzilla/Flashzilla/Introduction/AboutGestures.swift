//
//  AboutGestures.swift
//  Flashzilla
//
//  Created by Anthony You on 18/03/2021.
//

import SwiftUI

struct AboutGestures: View {
    /// Magnification effect gesture
//    @State private var currentAmount: CGFloat = 0
//    @State private var finalAmount: CGFloat = 1
    
    /// Rotation effect gesture
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)
    
    var body: some View {
        // MARK: Gestures demonstration
//        Text("Hello, World!")
            /// Double tap
//            .onTapGesture(count: 2) {
//                print("Double tapped!")
//            }
            /// Long pressure
//            .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
//                print("In progress: \(inProgress)!")
//            }) {
//                print("Long pressed!")
//            }
            /// Magnification effect gesture
//            .scaleEffect(finalAmount + currentAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { amount in
//                        self.currentAmount = amount - 1
//                    }
//                    .onEnded { amount in
//                        self.finalAmount += self.currentAmount
//                        self.currentAmount = 0
//                    }
//            )
            /// Rotation effect gesture
//            .rotationEffect(currentAmount + finalAmount)
//            .gesture(
//                RotationGesture()
//                    .onChanged { angle in
//                        self.currentAmount = angle
//                    }
//                    .onEnded { angle in
//                        self.finalAmount += self.currentAmount
//                        self.currentAmount = .degrees(0)
//                    }
//            )
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        /// Overrided by child element, unless using .highPriorityGesture
//        .highPriorityGesture(
//            TapGesture()
//                .onEnded { _ in
//                    print("VStack tapped")
//                }
//        )
        /// Triggered at the same time
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped")
                }
        )
    }
}

struct AboutGestures_Previews: PreviewProvider {
    static var previews: some View {
        AboutGestures()
    }
}
