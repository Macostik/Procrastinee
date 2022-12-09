//
//  OnboardingView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI
struct OnboardingView: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @State var isActive = false
    var body: some View {
        NavigationView {
            VStack {
                GetStartView {
                    onboardingViewModel.isPresentSuggestView = true
                }
                NavigationLink(destination: SuggestView(),
                               isActive: $onboardingViewModel.isPresentSuggestView) {}
            }
        }
        .ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
