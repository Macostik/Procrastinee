//
//  ProgressView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct ProgressView: View {
    @StateObject var viewModel: OnboardingViewModel
    var onNextScreen: (() -> Void)?
    var body: some View {
        VStack {
            Text(L10n.Onboarding.creatingProfile)
                .font(.system(size: 14).weight(.medium))
                .foregroundColor(Color.onboardingTextColor)
            ProgressBarView {
                onNextScreen?()
                viewModel.isPresentedSuccessCreatingAccount = true
            }
        }
        .padding(.bottom, 40)
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(viewModel: OnboardingViewModel())
    }
}
