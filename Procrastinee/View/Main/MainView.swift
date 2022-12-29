//
//  MainView.swift
//  Procrastinee
//
//  Created by Macostik on 15.12.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    @State private var selectedTab = 1
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            TabView(selection: $selectedTab) {
                TrackerSettingsView(viewModel: viewModel)
                    .tag(0)
                MainContentView(viewModel: viewModel)
                    .tag(1)
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
