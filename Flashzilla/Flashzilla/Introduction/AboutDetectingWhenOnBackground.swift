//
//  AboutDetectingWhenOnBackground.swift
//  Flashzilla
//
//  Created by Anthony You on 19/03/2021.
//

import SwiftUI

struct AboutDetectingWhenOnBackground: View {
    var body: some View {
        Text("Hello, World!")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("Moving to the background!")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("Moving back to the foreground!")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                print("User took a screenshot!")
            }
    }
    
    /// There are so many of these that I can’t realistically list them all here, so instead here are two more to try out:
///    UIApplication.significantTimeChangeNotification is called when the user changes their clock or when daylight savings time changes.
///    UIResponder.keyboardDidShowNotification is called when the keyboard is shown.
///    Each of these notifications works in exactly the same way: use onReceive() to catch notifications from the publisher, then take whatever action you want.
}

struct AboutDetectingWhenOnBackground_Previews: PreviewProvider {
    static var previews: some View {
        AboutDetectingWhenOnBackground()
    }
}
