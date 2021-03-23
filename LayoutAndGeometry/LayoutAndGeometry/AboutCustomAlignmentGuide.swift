//
//  AboutCustomAlignmentGuide.swift
//  LayoutAndGeometry
//
//  Created by Anthony You on 23/03/2021.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct AboutCustomAlignmentGuide: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("Cloud")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("example")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Game:")
                Text("Final Fantasy VII")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

struct AboutCustomAlignmentGuide_Previews: PreviewProvider {
    static var previews: some View {
        AboutCustomAlignmentGuide()
    }
}
