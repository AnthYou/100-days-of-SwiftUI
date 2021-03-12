//
//  AboutCoreImageSwiftUI.swift
//  Instafilter
//
//  Created by Anthony You on 11/03/2021.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct AboutCoreImageSwiftUI: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
//        let currentFilter = CIFilter.sepiaTone()
//        let currentFilter = CIFilter.pixellate()
//        let currentFilter = CIFilter.crystallize()
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return } // using the old API

//        currentFilter.inputImage = beginImage /// needed for CIFilter provided effects
//        currentFilter.intensity = 1 /// with sepiaTone()
//        currentFilter.scale = 100 /// with pixellate()
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey) // don't need it anymore with SwiftUI 2 /// for crystallize()
//        currentFilter.radius = 200 /// with crystallize()
        
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct AboutCoreImageSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        AboutCoreImageSwiftUI()
    }
}
