//
//  User.swift
//  RememberMe
//
//  Created by Anthony You on 14/03/2021.
//

import SwiftUI
import CoreLocation

struct User: Identifiable, Codable, Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
    
    let id: UUID
    let name: String
    let photo: UUID
    let annotation: CodableMKPointAnnotation?
    
    func loadPhoto(with photo: UUID) -> UIImage? {
        if let uiImage = FileManager.default.loadPhoto(withName: photo.uuidString) {
            return uiImage
        }
        return nil
    }
}
