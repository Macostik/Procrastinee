//
//  ContentView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var mainViewModel = MainViewModel()
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dependency) private var dependency
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                if onboardingViewModel.isPresentedMainView {
                    MainView(viewModel: mainViewModel)
                } else {
                    OnboardingView(onboardingViewModel: onboardingViewModel,
                                   mainViewModel: mainViewModel)
                }
            }
            .environment(\.screenSize, proxy.size)
            .onChange(of: scenePhase) { newPhase in
                let currentCalendar = Calendar.current
                if newPhase == .inactive {
                    if  mainViewModel.isTrackStarted {
                        if mainViewModel.isDeepMode == false {
                            mainViewModel.isCheckIn = true
                            mainViewModel.presentFinishedPopup = true
                        }
                        dependency.provider.notificationService
                            .sendAlertNotification(with: mainViewModel.isDeepMode ? 2 : 10)
                    }
                } else if newPhase == .active {
                    guard let lastTrackerTaskTimeStamp =
                            UserDefaults.standard
                        .value(forKey: Constants.lastUpdate) as? Date else { return }
                    let currentUser = dependency.provider.firebaseService.currentUser.value
                    if currentCalendar.isDateInToday(lastTrackerTaskTimeStamp) {
                        mainViewModel.todayFocusedValue = currentUser.todayFocused
                    } else if currentCalendar.component(Calendar.Component.weekday,
                                                        from: lastTrackerTaskTimeStamp) == 7 {
                        mainViewModel.totalWeeklyValue = 0
                    } else {
                        mainViewModel.todayFocusedValue = 0
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
