//
//  TrackerModel.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import Foundation

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

enum TrackerType {
    case promodoro, stopWatch
}
