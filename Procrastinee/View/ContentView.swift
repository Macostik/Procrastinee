//
//  ContentView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                if viewModel.isPresentedMainView {
                    MainView()
                } else {
                    OnboardingView()
                }
            }
            .environmentObject(viewModel)
            .environment(\.screenSize, proxy.size)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
