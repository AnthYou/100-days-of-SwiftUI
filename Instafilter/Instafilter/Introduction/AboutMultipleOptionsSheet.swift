//
//  AboutMultipleOptionsSheet.swift
//  Instafilter
//
//  Created by Anthony You on 11/03/2021.
//

import SwiftUI

struct AboutMultipleOptionsSheet: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                    .default(Text("Red")) { self.backgroundColor = .red },
                    .default(Text("Green")) { self.backgroundColor = .green },
                    .default(Text("Blue")) { self.backgroundColor = .blue },
                    .cancel()
                ])
            }
    }
}

struct AboutMultipleOptionsSheet_Previews: PreviewProvider {
    static var previews: some View {
        AboutMultipleOptionsSheet()
    }
}
