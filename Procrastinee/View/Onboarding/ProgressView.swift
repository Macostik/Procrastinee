//
//  ProgressView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct ProgressView: View {
    @StateObject var viewModel: OnboardingViewModel
    var body: some View {
        VStack {
            NavigationLink(destination: SuccessCreatingAccountView(),
                           isActive: $viewModel.isPresentSuccessCreatingAccount) {}
            Text(L10n.Onboarding.creatingProfile)
                .font(.system(size: 14).weight(.medium))
                .foregroundColor(Color.onboardingTextColor)
            ProgressBarView {
                viewModel.isPresentSuccessCreatingAccount = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(viewModel: OnboardingViewModel())
    }
}
