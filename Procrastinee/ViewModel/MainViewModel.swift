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
    }
    func creatTask() {
        isTaskCategoryPresented = false
        isTrackStarted = false
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
