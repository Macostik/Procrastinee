//
//  MainViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var selectedTrackerType: TrackerSettingsType = .stopWatch
    @Published var selectedTracker: TrackerType = .tracker
    @Published var selectedTask = TaskType.sport
    @Published var taskName = ""
    @Published var isSetTaskTime = false
    @Published var isTaskCategoryPresented = false
    @Published var isTrackStarted = false
    @Published var timer = Timer.publish(every: 0.1, on: .main, in: .common)
    @Published var hasTaskPaused = false
    @Published var presentFinishedPopup = false
    @Published var taskIsOver = false
    private var cancellable: Set<AnyCancellable> = []
    init() {
        $isTaskCategoryPresented
            .receive(on: DispatchQueue.main)
            .map({ [unowned self] in
                !$0 &&
                !self.taskName.isEmpty })
            .assign(to: \.isTrackStarted, on: self)
            .store(in: &cancellable)
        $isTrackStarted
            .sink { [unowned self] value in
                if value {
                    _ = self.timer.connect()
                }
            }
            .store(in: &cancellable)
        $taskIsOver
            .dropFirst(1)
            .receive(on: DispatchQueue.main)
            .map({!$0})
            .assign(to: \.isTrackStarted, on: self)
            .store(in: &cancellable)
        $taskIsOver
            .dropFirst(1)
            .receive(on: DispatchQueue.main)
            .map({!$0})
            .assign(to: \.hasTaskPaused, on: self)
            .store(in: &cancellable)
        $taskIsOver
            .dropFirst(1)
            .receive(on: DispatchQueue.main)
            .map({!$0})
            .assign(to: \.presentFinishedPopup, on: self)
            .store(in: &cancellable)
    }
    func creatTask() {
        isTaskCategoryPresented = false
        isTrackStarted = false
    }
}
