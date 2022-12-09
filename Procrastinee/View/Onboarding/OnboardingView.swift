//
//  OnboardingView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI
struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    var body: some View {
        VStack {
            NavigationLink(destination: SuggestedView(viewModel: viewModel),
                           isActive: $viewModel.isPresentSuggestedView) {}
            GetStartedView(viewModel: viewModel)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
