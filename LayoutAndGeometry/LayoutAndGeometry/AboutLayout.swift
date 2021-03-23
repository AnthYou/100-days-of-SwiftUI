//
//  AboutLayout.swift
//  LayoutAndGeometry
//
//  Created by Anthony You on 23/03/2021.
//

import SwiftUI

struct AboutLayout: View {
    var body: some View {
        Text("Hello, World!")
            .padding(20)
            .background(Color.red)
        // Color.red
        
        // Order matters. In fact, SwiftUI reads from the bottom to the top.
        
        /*
         SwiftUI: You can have the whole screen, how much of it do you need, ContentView?
         ContentView: You can have the whole screen, how much of it do you need, background?
         Background: You can have the whole screen, how much of it do you need, padding?
         Padding: You can have the whole screen minus 20 points on each side, how much of it do you need, text?
         Text: I need X by Y.
         Padding: I need X by Y plus 20 points on each side.
         Background: I need X by Y plus 20 points on each side.
         ContentView: I need X by Y plus 20 points on each side.
         SwiftUI: OK; I’ll center you.
         */
    }
}

struct AboutLayout_Previews: PreviewProvider {
    static var previews: some View {
        AboutLayout()
    }
}
