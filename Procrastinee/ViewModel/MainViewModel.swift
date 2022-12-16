//
//  MainViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var selectedTracker: TrackerType = .stopWatch
}
