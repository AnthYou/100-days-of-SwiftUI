//
//  MKPointAnnotation+ObservableObject.swift
//  RememberMe
//
//  Created by Anthony You on 17/03/2021.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }
}
