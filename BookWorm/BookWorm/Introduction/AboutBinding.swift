//
//  AboutBinding.swift
//  BookWorm
//
//  Created by Anthony You on 07/03/2021.
//

import SwiftUI

struct AboutBinding: View {
    @State private var rememberMe = false

    var body: some View {
        Toggle(isOn: $rememberMe) {
            Text("Remember Me")
        }
    }
}

struct AboutBinding_Previews: PreviewProvider {
    static var previews: some View {
        AboutBinding()
    }
}
