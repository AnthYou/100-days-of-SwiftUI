//
//  AddView.swift
//  HabitsTracker
//
//  Created by Anthony You on 06/03/2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var activityTitle = ""
    @State private var activityDescription = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What do you want to track?")) {
                    TextField("Title", text: $activityTitle)
                }
                Section(header: Text("What is your activity about?")) {
                    TextField("Description", text: $activityDescription)
                }
            }
            .navigationBarTitle("Add a new activity")
            .navigationBarItems(trailing: Button(action: {
                self.activities.trackedActivities.append(Activity(title: self.activityTitle, description: self.activityDescription))
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            }))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
