//
//  ReadingValueControls.swift
//  AccessibilityProject
//
//  Created by Anthony You on 14/03/2021.
//

import SwiftUI

struct ReadingValueControls: View {
    @State private var estimate = 25.0
    @State private var rating = 3

    var body: some View {
        VStack {
            Slider(value: $estimate, in: 0...50)
                .padding()
                .accessibility(value: Text("\(Int(estimate))"))
            Stepper("Rate our services: \(rating)/5", value: $rating, in: 1...5)
                .accessibility(value: Text("\(rating) out of 5"))
        }
    }
}

struct ReadingValueControls_Previews: PreviewProvider {
    static var previews: some View {
        ReadingValueControls()
    }
}
