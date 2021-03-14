//
//  HidingGrouping.swift
//  AccessibilityProject
//
//  Created by Anthony You on 14/03/2021.
//

import SwiftUI

struct HidingGrouping: View {
    var body: some View {
        VStack {
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            // .accessibilityElement(children: .combine) // read both lines together, marking a little pause between both
            .accessibilityElement(children: .ignore) // ignore accessibility
            .accessibility(label: Text("Your score is 1000")) // reads all at once (more natural)
            
            Image(decorative: "character") // tells VoiceOver not to read the label, unless it has important traits such as button
                .resizable()
                .scaledToFit()
                .accessibility(hidden: true) // go a step further and ignores it even if it has important traits
        }
    }
}

struct HidingGrouping_Previews: PreviewProvider {
    static var previews: some View {
        HidingGrouping()
    }
}
