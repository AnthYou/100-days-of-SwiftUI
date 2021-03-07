//
//  Activity.swift
//  HabitsTracker
//
//  Created by Anthony You on 06/03/2021.
//

import Foundation

struct Activity: Identifiable, Codable {
    private(set) var id = UUID()
    let title: String
    let description: String
    var completedTimes: Int = 0
}
