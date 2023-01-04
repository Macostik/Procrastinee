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
    @Published var isBreakingTime = false
    @Published var pickerViewSelectedIndex = 0
    @Published var selectedTask = TaskType.sport
    @Published var isDeepMode = false
    @Published var taskName = ""
    @Published var isSetTaskTime = false
    @Published var isTrackStarted = false
    @Published var hasTaskPaused = false
    @Published var presentFinishedPopup = false
    @Published var taskIsOver = false
    @Published var trackIsOver = false
    @Published var selecteTime = ""
    @Published var isTaskCategoryPresented = false
    @Published var weekEndInValue = ""
    @Published var breakTime = 10
    @Published var workPeriodTime = 60
    @Published var stopWatchingTrackingTime = 10
    @Published var isTrackShouldStop = false
    @Published var isBreakingTimeShouldStop = false
    @Published var isReverseAnimation = false
    @Published var trackAnimationFinished = false
    @Published var todayFocusedValue = 0
    @Published var dailyAverageValue = 0
    @Published var totalWeeklyValue = 0
    @Published var counter: CGFloat = -89
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var timeCounterTimer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @Published var groupTask = [
        GroupTask(index: 0, key: "Today", value: [])
    ]
    private var firebaseService: FirebaseInteractor {
        dependency.provider.firebaseService
    }
    private var notificationService: NotificationInteractor {
        dependency.provider.notificationService
    }
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
                    let workingTime = (selectedTrackerType == .stopWatch ?
                                       stopWatchingTrackingTime : workPeriodTime) * 60
                    let interval = CGFloat(CGFloat(workingTime)/2/(endCycleValue - beginCycleValue))
                    timer = Timer.publish(every: interval,
                                          on: .main,
                                          in: .common).autoconnect()
                    timeCounterTimer = Timer.publish(every: 60,
                                          on: .main,
                                          in: .common).autoconnect()
                } else {
                    timer.upstream.connect().cancel()
                    timeCounterTimer.upstream.connect().cancel()
                }
            }
            .store(in: &cancellable)
        fetchTrackOver()
        fetchAllTasks()
        observeBreakingTime()
        observeSelectedDeal()
        observeTrackingAnimationFinish()
    }
    func onAppearMainScreen() {
    }
    func onAppearRankingScreen() {
        endInWeek()
    }
    private func observeBreakingTime() {
        $isBreakingTime
            .sink { [unowned self] value in
                if self.selectedTrackerType == .promodoro {
                    if value {
                        let workingTime = breakTime * 60
                        let interval = CGFloat(CGFloat(workingTime)/2/(endCycleValue - beginCycleValue))
                        timer = Timer.publish(every: interval,
                                              on: .main,
                                              in: .common).autoconnect()
                    }
                }
            }
            .store(in: &cancellable)
    }
    private func observeSelectedDeal() {
        $selectedDeal
            .map({ $0 == .tracker ? 0 : 1 })
            .assign(to: \.pickerViewSelectedIndex, on: self)
            .store(in: &cancellable)
    }
    private func fetchTrackOver() {
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
        let task = TaskItem(state: "planned",
                             type: selectedTask.rawValue,
                             name: taskName,
                             fromTime: selecteTime,
                             forTime: "")
        firebaseService.addTask(task: task)
        notificationService.scheduleNotification(with: task)
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
        firebaseService.tasks
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] itemList in
                self?.divideByDate(itemList)
                self?.observeWorkingTime()
            }
            .store(in: &cancellable)
    }
    private func divideByDate(_ list: [TaskItem]) {
        if list.isEmpty == false {
            let listByDate = Dictionary(grouping: list,
                                        by: { item in item.timestamp.getDate() })
            var listItem: [GroupTask] = []
            for key in listByDate.keys {
                guard let key = key,
                      let value = listByDate[key]?
                    .sorted(by: { $0.convertFromTimeToDate < $1.convertFromTimeToDate })
                else { return }
                let group = GroupTask(index: 0,
                                      key: key,
                                      value: value)
                listItem.append(group)
            }
            groupTask =
            listItem.sorted(by: {($0.value.first?.timestamp ?? 0) > ($1.value.first?.timestamp ?? 0)})
        }
    }
    private func observeWorkingTime() {
        let currentUser = self.firebaseService
            .currentUser.value
        self.todayFocusedValue = currentUser.todayFocused
        self.dailyAverageValue = currentUser.dailyAverage
        self.totalWeeklyValue = currentUser.totalWeekly
    }
    private func observeTrackingAnimationFinish() {
        $trackAnimationFinished
            .sink { [weak self] value in
                if value {
                    self?.updateTrackerTimes()
                }
            }
            .store(in: &cancellable)
    }
    private func updateTrackerTimes() {
        firebaseService
            .updateTrackUserTimes(todayTotalTime: self.todayFocusedValue,
                                  dailyAverage: self.dailyAverageValue,
                                  totalWeekly: self.totalWeeklyValue)
    }
}

extension Int {
    var hour: String {
        "\(self / 60)"
    }
    var minute: String {
        "\(self % 60)"
    }
}
