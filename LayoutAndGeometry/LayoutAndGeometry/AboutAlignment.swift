//
//  AboutAlignment.swift
//  LayoutAndGeometry
//
//  Created by Anthony You on 23/03/2021.
//

import SwiftUI

struct AboutAlignment: View {
    var body: some View {
        ScrollView {
            Text("Live long and prosper")
                .frame(width: 300, height: 300, alignment: .topLeading) // aligns text in the frame on the top left corner
            
            HStack(alignment: .lastTextBaseline) {
                Text("Live")
                    .font(.caption)
                Text("long")
                Text("and")
                    .font(.title)
                Text("prosper")
                    .font(.largeTitle)
            }
            
            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .alignmentGuide(.leading) { d in d[.trailing] }
                Text("This is a longer line of text")
            }
            .background(Color.red)
            .frame(width: 400, height: 400)
            .background(Color.blue)
            
            VStack(alignment: .leading) {
                ForEach(0..<10) { position in
                    Text("Number \(position)")
                        .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
                }
            }
            .background(Color.red)
            .frame(width: 400, height: 400)
            .background(Color.blue)
        }
    }
}

struct AboutAlignment_Previews: PreviewProvider {
    static var previews: some View {
        AboutAlignment()
    }
}
