//
//  AboutImageInterpolation.swift
//  HotProspects
//
//  Created by Anthony You on 17/03/2021.
//

import SwiftUI

struct AboutImageInterpolation: View {
    var body: some View {
        Image("example")
            .interpolation(.none) // controls pixel blending
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct AboutImageInterpolation_Previews: PreviewProvider {
    static var previews: some View {
        AboutImageInterpolation()
    }
}
