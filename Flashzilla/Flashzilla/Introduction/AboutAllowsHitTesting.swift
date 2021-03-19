//
//  AboutAllowsHitTesting.swift
//  Flashzilla
//
//  Created by Anthony You on 19/03/2021.
//

import SwiftUI

struct AboutAllowsHitTesting: View {
    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//
//            Circle()
//                .fill(Color.red)
//                .frame(width: 300, height: 300)
//                // .contentShape(Rectangle()) // tapable area is now a rectangle
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//                // .allowsHitTesting(false) // disable user interactivity
//        }
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle()) // needed here otherwise it won't allow tapping the Spacer()
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}

struct AboutAllowsHitTesting_Previews: PreviewProvider {
    static var previews: some View {
        AboutAllowsHitTesting()
    }
}
