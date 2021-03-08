//
//  AboutSizeClasses.swift
//  BookWorm
//
//  Created by Anthony You on 08/03/2021.
//

import SwiftUI

struct AboutSizeClasses: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            return AnyView(HStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}

struct AboutSizeClasses_Previews: PreviewProvider {
    static var previews: some View {
        AboutSizeClasses()
    }
}
