//
//  MainViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import Foundation
import Combine
import SwiftUI

var smoothAnimationValue: CGFloat = 10

class MainViewModel: ObservableObject {
    @Environment(\.dependency) private var dependency
    @Published var selectedTrackerType: TrackerSettingsType = .stopWatch
    @Published var selectedTracker: TrackerType = .tracker
    @Published var selectedDeal: DealType = .tracker
    @Published var isBreakingTime = false
    @Published var pickerViewSelectedIndex = 0
    @Published var selectedTask = TaskType.sport
    @Published var isDeepMode = true
    @Published var taskName = ""
    @Published var isTrackStarted = false
    @Published var presentFinishedPopup = false
    @Published var taskIsOver = false
    @Published var trackIsOver = false
    @Published var selectedTaskTime = ""
    @Published var isTaskCategoryPresented = false
    @Published var weekEndInValue = ""
    @Published var breakTime = 10
    @Published var workPeriodTime = 60
    @Published var stopWatchingTrackingTime = 1
    @Published var isTrackShouldStop = false
    @Published var isBreakingTimeShouldStop = false
    @Published var isReverseAnimation = false
    @Published var trackAnimationFinished = false
    @Published var isCheckIn = false
    @Published var todayFocusedValue = 0
    @Published var dailyAverageValue = 0
    @Published var totalWeeklyValue = 0
    @Published var counter: CGFloat = -89
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var timeCounterTimer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @Published var progressDots = 0
    @Published var counterDots: CGFloat = 200
    @Published var currentTask: TaskItem?
    @Published var groupTask = [
        GroupTask(index: 0, key: "Today", value: [])
    ]
    @Published var hasTaskPaused = false {
        willSet {
            if newValue {
                UserDefaults.standard.set(newValue, forKey: Constants.tapToPause)
            }

        }
    }
    @Published var hasTappedToHold = false {
        willSet {
            if newValue {
                UserDefaults.standard.set(newValue, forKey: Constants.tapToHold)
            }
        }
    }
    @Published var hasTappedToStart = false {
        willSet {
            if newValue {
                UserDefaults.standard.set(newValue, forKey: Constants.tapToStart)
            }
        }
    }
    @Published var hasSlidToLeft = false {
        willSet {
            if newValue {
                UserDefaults.standard.set(newValue, forKey: Constants.slideToLeft)
            }
        }
    }
    var interval: CGFloat = 1
    private var firebaseService: FirebaseInteractor {
        dependency.provider.firebaseService
    }
    private var notificationService: NotificationInteractor {
        dependency.provider.notificationService
    }
    private var cancellable: Set<AnyCancellable> = []
    init() {
        fetchTrackOver()
        fetchAllTasks()
        observeWorkingTime()
        observeTrackingTime()
        observeBreakingTime()
        observeSelectedDeal()
    }
    func createTask(inProcess: Bool = true) {
        let fromTime = inProcess ? Date().convertDateToAmPmTime : selectedTaskTime
        let task = TaskItem(state: "planned",
                            type: selectedTask.rawValue,
                            name: taskName,
                            fromTime: fromTime ,
                            forTime: "")
        firebaseService.addTask(task: task)
        if inProcess == false {
            notificationService.scheduleNotification(with: task)
        } else {
            currentTask = task
        }
    }
    func updateFinishedTask() {
        firebaseService.updateFinishedTask(currentTask)
        self.updateTrackerTimes()
    }
}

extension MainViewModel {
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
                      let value = listByDate[key]?
                    .sorted(by: { $0.convertFromTimeToDate > $1.convertFromTimeToDate })
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
    private func observeTrackingTime() {
        $isTrackStarted
            .sink { [unowned self] value in
                if value {
                    let workingTime = (selectedTrackerType == .stopWatch ?
                                       stopWatchingTrackingTime : workPeriodTime) * 60
                    interval =
                    CGFloat(CGFloat(workingTime)/smoothAnimationValue/2/(endCycleValue - beginCycleValue))
                    timer = Timer.publish(every: interval,
                                          on: .main,
                                          in: .common).autoconnect()
                    timeCounterTimer = Timer.publish(every: 10,
                                          on: .main,
                                          in: .common).autoconnect()
                } else {
                    timer.upstream.connect().cancel()
                    timeCounterTimer.upstream.connect().cancel()
                }
            }
            .store(in: &cancellable)
    }
    private func observeWorkingTime() {
        firebaseService.currentUser
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [unowned self] user in
                self.dailyAverageValue = user.dailyAverage
                self.totalWeeklyValue = user.totalWeekly
                self.todayFocusedValue = user.todayFocused
            })
            .store(in: &cancellable)
    }
    private func updateTrackerTimes() {
        UserDefaults.standard.setValue(Date(), forKey: Constants.lastUpdate)
        firebaseService
            .updateTrackUserTimes(todayTotalTime: self.todayFocusedValue,
                                  dailyAverage: self.dailyAverageValue,
                                  totalWeekly: self.totalWeeklyValue)
    }
    private func observeBreakingTime() {
        $isBreakingTime
            .sink { [unowned self] value in
                if self.selectedTrackerType == .promodoro {
                    let workingTime = (value ? breakTime : workPeriodTime) * 60
                        let interval =
                    CGFloat(CGFloat(workingTime)/smoothAnimationValue/2/(endCycleValue - beginCycleValue))
                        timer = Timer.publish(every: interval,
                                              on: .main,
                                              in: .common).autoconnect()
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
}
