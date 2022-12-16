//
//  MainView.swift
//  Procrastinee
//
//  Created by Macostik on 15.12.2022.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 1
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            TabView(selection: $selectedTab) {
                TrackerSettingsView()
                    .tag(0)
                TrackerView()
                    .tag(1)
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
