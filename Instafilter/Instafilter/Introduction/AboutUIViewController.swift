//
//  AboutUIViewController.swift
//  Instafilter
//
//  Created by Anthony You on 11/03/2021.
//

import SwiftUI

/// Already declared
//class ImageSaver: NSObject {
//    func writeToPhotoAlbum(image: UIImage) {
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
//    }
//
//    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        print("Save finished!")
//    }
//}

struct AboutUIViewController: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct AboutUIViewController_Previews: PreviewProvider {
    static var previews: some View {
        AboutUIViewController()
    }
}
