//
//  AboutCoreData.swift
//  BookWorm
//
//  Created by Anthony You on 08/03/2021.
//

import SwiftUI

//struct AboutCoreData: View {
//    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
//    @Environment(\.managedObjectContext) var moc
//    
//    var body: some View {
//        VStack {
//            List {
//                ForEach(students, id: \.id) { student in
//                    Text(student.name ?? "Unknown")
//                }
//            }
//            Button("Add") {
//                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
//                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
//
//                let chosenFirstName = firstNames.randomElement()!
//                let chosenLastName = lastNames.randomElement()!
//
//                let student = Student(context: self.moc)
//                student.id = UUID()
//                student.name = "\(chosenFirstName) \(chosenLastName)"
//                
//                try? self.moc.save()
//            }
//        }
//    }
//}
//
//struct AboutCoreData_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutCoreData()
//    }
//}
