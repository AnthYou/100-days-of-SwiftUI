//
//  ActivityView.swift
//  HabitsTracker
//
//  Created by Anthony You on 06/03/2021.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activities: Activities
    var activity: Activity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(activity.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(activity.description)
            HStack {
                Text("Completed \(activity.completedTimes) times")
                    .font(.headline)

                Button(action: {
                    updateActivity(by: 1)
                }, label: {
                    Image(systemName: "plus")
                    Text("Add completion")
                })
            }
            Spacer()
        }
    }
    
    func updateActivity(by change: Int) {
        var activity = self.activity
        activity.completedTimes += change
        self.activities.update(activity: activity)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activities: Activities(), activity: Activity(title: "Roller", description: "For fun", completedTimes: 10))
    }
}
