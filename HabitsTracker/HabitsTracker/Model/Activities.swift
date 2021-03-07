//
//  Activities.swift
//  HabitsTracker
//
//  Created by Anthony You on 06/03/2021.
//

import Foundation

class Activities: ObservableObject {
    @Published var trackedActivities = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(trackedActivities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: data) {
                self.trackedActivities = decoded
                return
            }
        }
        self.trackedActivities = [Activity]()
    }
    
    
    func update(activity: Activity) {
        guard let index = getIndex(activity: activity) else { return }
        
        trackedActivities[index] = activity
    }
    
    private func getIndex(activity: Activity) -> Int? {
        return trackedActivities.firstIndex(where: { $0.id == activity.id })
    }
}
