//
//  DetailView.swift
//  RememberMe
//
//  Created by Anthony You on 15/03/2021.
//

import SwiftUI

struct DetailView: View {
    var user: User
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(uiImage: user.loadPhoto(with: user.photo) ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, height: geo.size.height / 2, alignment: .center)
                Text(user.name)
                    .font(.largeTitle)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: UUID(), name: "Anthony", photo: UUID())
        DetailView(user: user)
    }
}
