//
//  AboutObjectWillChange.swift
//  HotProspects
//
//  Created by Anthony You on 17/03/2021.
//

import SwiftUI

class DelayedUpdater: ObservableObject {
    // @Published var value = 0
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct AboutObjectWillChange: View {
    @ObservedObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct AboutObjectWillChange_Previews: PreviewProvider {
    static var previews: some View {
        AboutObjectWillChange()
    }
}
