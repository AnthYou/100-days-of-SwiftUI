//
//  AboutNSPredicate.swift
//  CoreDataProject
//
//  Created by Anthony You on 08/03/2021.
//

import SwiftUI
import CoreData

struct AboutNSPredicate: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
    // Syntax:
    
    // NSPredicate(format: "universe == %@", "Star Wars")
    // Return where universe == "Star Wars"
    
    // NSPredicate(format: "name < %@", "F")
    // Returns where name are included in A..<F
    
    // NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
    // Returns if universe is included in the array
    
    // NSPredicate(format: "name BEGINSWITH %@", "E")
    // Returns if name begins with "E" - case-sensitive
    
    // NSPredicate(format: "name BEGINSWITH[c] %@", "e")
    // Returns if name begins with "e" - case-insensitive
    
    // NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")
    // Returns if name doesn't begin with e - case-insensitive
    
    ///  If you need more complicated predicates, join them using AND to build up as much precision as you need, or add an import for Core Data and take a look at NSCompoundPredicate – it lets you build one predicate out of several smaller ones.

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
            }
        }
    }
}

struct AboutNSPredicate_Previews: PreviewProvider {
    static var previews: some View {
        AboutNSPredicate()
    }
}
