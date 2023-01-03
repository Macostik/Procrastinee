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
    @Published var counter: CGFloat = -89
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
    @Published var todayFocusedValue = ""
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var promodoroTimer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
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
                } else {
                    timer.upstream.connect().cancel()
                }
            }
            .store(in: &cancellable)
        fetchTrackOver()
        fetchAllTasks()
        observeBreakingTime()
        observeSelectedDeal()
        observeTrackFinish()
        fetchCurrentUser()
    }
    func onAppearMainScreen() {
    }
    func onAppearRankingScreen() {
        endInWeek()
    }
    private func fetchCurrentUser() {
        firebaseService.currentUser
            .sink { _ in
            } receiveValue: { [weak self] _ in
                self?.observeTotalWorkingTime()
            }
            .store(in: &cancellable)
    }
    private func observeTotalWorkingTime() {
        let totalTime = self.firebaseService
            .currentUser.value.totalTime
        let focusHour = (Int(totalTime) ?? 0) / 60
        let focusMinute = (Int(totalTime) ?? 0) % 60
        let todayFocusedValue = "\(focusHour)" + "h " + "\(focusMinute)" + "m"
        self.todayFocusedValue = todayFocusedValue
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
    private func observeTrackFinish() {
        $trackIsOver
            .dropFirst(1)
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] value in
                if value {
                    let time = self.selectedTrackerType == .promodoro ?
                    self.workPeriodTime : self.stopWatchingTrackingTime
                    self.firebaseService
                        .updateTotalTime(with: time)
                }
            }
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
                      let value = listByDate[key]?.sorted(by: { $0.timestamp < $1.timestamp })
                else { return }
                let group = GroupTask(index: key == "Today" ? 0 : -1, key: key, value: value)
                listItem.append(group)
            }
            groupTask =
            listItem.sorted(by: {($0.value.first?.timestamp ?? 0) > ($1.value.first?.timestamp ?? 0)})
        }
    }
}
