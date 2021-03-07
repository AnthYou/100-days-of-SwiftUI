//
//  MainView.swift
//  HabitsTracker
//
//  Created by Anthony You on 06/03/2021.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var activities = Activities()
    @State private var isAddingActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.trackedActivities) { activity in
                    NavigationLink(
                        destination: ActivityView(activities: activities, activity: activity),
                        label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(activity.title)
                                    Text("Completed \(activity.completedTimes) times")
                                }
                                Spacer()
                            }
                        }
                    )
                }
                .onDelete(perform: removeActivities)
            }
                .navigationBarTitle("HabitsTracker")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    self.isAddingActivity.toggle()
                }, label: {
                    Image(systemName: "plus")
                }))
                .sheet(isPresented: $isAddingActivity, content: {
                    AddView(activities: activities)
                })
        }
    }
    
    func removeActivities(at offsets: IndexSet) {
        activities.trackedActivities.remove(atOffsets: offsets)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
