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
                if newPhase == .inactive &&
                    mainViewModel.isTrackStarted &&
                    mainViewModel.isDeepMode {
                    dependency.provider.notificationService.sendAlertNotification()
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
