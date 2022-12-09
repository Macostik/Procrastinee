//
//  OnboardingView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI
struct OnboardingView: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    var body: some View {
        VStack {
            NavigationLink(destination: SuggestedView(),
                           isActive: $onboardingViewModel.isPresentSuggestedView) {}
            GetStartedView {
                onboardingViewModel.isPresentSuggestedView = true
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
