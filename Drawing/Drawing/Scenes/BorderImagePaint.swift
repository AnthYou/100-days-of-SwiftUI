//
//  BorderImagePaint.swift
//  Drawing
//
//  Created by Anthony You on 06/03/2021.
//

import SwiftUI

struct BorderImagePaint: View {
    var body: some View {
        Capsule()
            .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
            .frame(width: 300, height: 200)
    }
}

struct BorderImagePaint_Previews: PreviewProvider {
    static var previews: some View {
        BorderImagePaint()
    }
}
