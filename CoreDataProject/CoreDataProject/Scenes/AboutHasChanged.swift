//
//  AboutHasChanged.swift
//  CoreDataProject
//
//  Created by Anthony You on 08/03/2021.
//

import SwiftUI

struct AboutHasChanged: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Button("Save") {
            if self.moc.hasChanges {
                try? self.moc.save()
            }
        }
    }
}

struct AboutHasChanged_Previews: PreviewProvider {
    static var previews: some View {
        AboutHasChanged()
    }
}
