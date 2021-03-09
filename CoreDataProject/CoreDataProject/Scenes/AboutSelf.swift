//
//  AboutSelf.swift
//  CoreDataProject
//
//  Created by Anthony You on 08/03/2021.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct AboutSelf: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]

    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct AboutSelf_Previews: PreviewProvider {
    static var previews: some View {
        AboutSelf()
    }
}
