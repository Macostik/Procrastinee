//
//  MainViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import Foundation
import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    @Environment(\.dependency) private var dependency
    @Published var selectedTrackerType: TrackerSettingsType = .stopWatch
    @Published var selectedTracker: TrackerType = .tracker
    @Published var selectedDeal: DealType = .tracker
    @Published var pickerViewSelectedIndex = 0
    @Published var selectedTask = TaskType.sport
    @Published var isDeepMode = false
    @Published var taskName = ""
    @Published var isSetTaskTime = false
    @Published var isTrackStarted = false
    @Published var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @Published var counter: CGFloat = -89
    @Published var hasTaskPaused = false
    @Published var presentFinishedPopup = false
    @Published var taskIsOver = false
    @Published var selecteTime = ""
    @Published var isTaskCategoryPresented = false
    @Published var weekEndInValue = ""
    @Published var groupTask = [
        GroupTask(index: 0,
                  key: "Today",
                  value: [])
    ]
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
                    self.taskName = ""
                    self.selectedTask = .sport
                } else {
                    timer.upstream.connect().cancel()
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
        $selectedDeal
            .map({ $0 == .tracker ? 0 : 1 })
            .assign(to: \.pickerViewSelectedIndex, on: self)
            .store(in: &cancellable)
        endInWeek()
        fetchAllTasks()
    }
    func creatTask() {
        isTaskCategoryPresented = false
        isTrackStarted = false
        let firebaseService = dependency.provider.firebaseService
        let remoteTask = RemoteTask(name: taskName,
                                    type: selectedTask.rawValue,
                                    time: selecteTime)
        firebaseService.addTask(task: remoteTask)
    }
    private func endInWeek() {
        let endOfWeek = Date().endOfWeek ?? Date()
        let diffs = Calendar.current.dateComponents([.day, .hour, .minute],
                                                    from: Date(),
                                                    to: endOfWeek)
        let day = diffs.day ?? 0
        let hour = diffs.hour ?? 0
        let minutes = diffs.minute ?? 0
        weekEndInValue = "\(day)" + "d:" + "\(hour)" + "h:" + "\(minutes)" + "m"
    }
    private func fetchAllTasks() {
        dependency.provider.firebaseService.tasks
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] tasks in
                guard var todayValue = self?.groupTask.first else { return }
                todayValue.value.removeAll()
                for task in tasks {
                    let localTask = LocalTask(state: .planned,
                                              type: TaskType(rawValue: task.type) ?? .education,
                                              name: task.name,
                                              fromTime: task.time,
                                              forTime: "")
                    todayValue.value.append(localTask)
                }
                todayValue.value.sort(by: { $0.fromTime < $1.fromTime })
                self?.groupTask[0] = todayValue
            }
            .store(in: &cancellable)
    }
}

extension Date {
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian
            .date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                 from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
}
