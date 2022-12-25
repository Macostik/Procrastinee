//
//  TrackerModel.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import Foundation
import Combine

struct Sound: Identifiable {
    let id = UUID()
    let name: String
}

var soundList = [
    Sound(name: "Campfire"),
    Sound(name: "Rain"),
    Sound(name: "River"),
    Sound(name: "Nature")
]

enum TrackerSettingsType {
    case promodoro, stopWatch
}

enum DealType: String {
    case tracker, planning
}

enum TrackerType {
    case tracker, ranking
}

enum TaskType: String, CaseIterable {
    case  sport, education, work, study
}

enum TaskState: String {
    case planned, completed
}
