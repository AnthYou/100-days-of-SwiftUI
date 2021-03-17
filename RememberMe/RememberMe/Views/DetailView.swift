//
//  DetailView.swift
//  RememberMe
//
//  Created by Anthony You on 15/03/2021.
//

import SwiftUI
import MapKit

struct DetailView: View {
    var user: User
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(uiImage: user.loadPhoto(with: user.photo) ?? UIImage(imageLiteralResourceName: "Example"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, alignment: .center)
                MapView(annotation: user.annotation)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationTitle(user.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: UUID(), name: "Anthony", photo: UUID(), annotation: CodableMKPointAnnotation())
        DetailView(user: user)
    }
}
