//
//  AboutPackageDep.swift
//  HotProspects
//
//  Created by Anthony You on 17/03/2021.
//

import SamplePackage
import SwiftUI

struct AboutPackageDep: View {
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }

    var body: some View {
        Text(results)
    }
}

struct AboutPackageDep_Previews: PreviewProvider {
    static var previews: some View {
        AboutPackageDep()
    }
}
