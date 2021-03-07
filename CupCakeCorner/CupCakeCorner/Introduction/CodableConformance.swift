//
//  CodableConformance.swift
//  CupCakeCorner
//
//  Created by Anthony You on 07/03/2021.
//

import SwiftUI

class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "Anthony You"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct CodableConformance: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct CodableConformance_Previews: PreviewProvider {
    static var previews: some View {
        CodableConformance()
    }
}
