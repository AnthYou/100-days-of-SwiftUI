//
//  AboutTabView.swift
//  HotProspects
//
//  Created by Anthony You on 17/03/2021.
//

import SwiftUI

struct AboutTabView: View {
    @State private var selectedTab = ""
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    self.selectedTab = "tab2"
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("One")
                }
            
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
                .tag("tab2")
        }
    }
}

struct AboutTabView_Previews: PreviewProvider {
    static var previews: some View {
        AboutTabView()
    }
}
