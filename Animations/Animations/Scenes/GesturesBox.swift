//
//  Gestures.swift
//  Animations
//
//  Created by Anthony You on 04/03/2021.
//

import SwiftUI

struct GesturesBox: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            self.dragAmount = .zero
                        }
                    }
            )
    }
}

struct Gestures_Previews: PreviewProvider {
    static var previews: some View {
        GesturesBox()
    }
}
