//
//  AboutTriggeringEventsRepeatedlyTimer.swift
//  Flashzilla
//
//  Created by Anthony You on 19/03/2021.
//

import SwiftUI

struct AboutTriggeringEventsRepeatedlyTimer: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    /// Using tolarence: This allows iOS to perform important energy optimization, because it can fire the timer at any point between its scheduled fire time and its scheduled fire time plus the tolerance you specify. In practice this means the system can perform timer coalescing: it can push back your timer just a little so that it fires at the same time as one or more other timers, which means it can keep the CPU idling more and save battery power.
    @State private var counter = 0

    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if self.counter == 5 {
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                self.counter += 1
            }
    }
}

struct AboutTriggeringEventsRepeatedlyTimer_Previews: PreviewProvider {
    static var previews: some View {
        AboutTriggeringEventsRepeatedlyTimer()
    }
}
