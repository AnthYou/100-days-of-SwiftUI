//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Anthony You on 23/03/2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isReplayingWrongCards: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text("Answers you don't know will go at the end of the stack")) {
                    Toggle(isOn: $isReplayingWrongCards, label: {
                        Text("Replay wrong cards?")
                    })
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isReplayingWrongCards: Binding.constant(false))
    }
}
