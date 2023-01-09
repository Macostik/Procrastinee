//
//  TrackerModel.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import Foundation
import Combine

enum Sound: String, CaseIterable {
    case campfire, rain, stream, nature
    var soundName: String {
        switch self {
        case .campfire: return "Campfire"
        case .rain: return "Rain"
        case .stream: return "Stream"
        case .nature: return "Nature"
        }
    }
}

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
    case sport, education, work, study
}

enum TaskState: String {
    case planned, completed
}
