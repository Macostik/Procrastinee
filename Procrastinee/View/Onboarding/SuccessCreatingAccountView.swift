//
//  SuccessCreatingAccountView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct SuccessCreatingAccountView: View {
    @StateObject var viewModel: OnboardingViewModel
    var onNextScreen: (() -> Void)?
    var body: some View {
        VStack {
            Image.successMark
            Text(L10n.Onboarding.accountCreateSuccess)
                .font(.system(size: 14).weight(.medium))
                .foregroundColor(Color.onboardingTextColor)
                .multilineTextAlignment(.center)
                .padding(.top, 6)
                .padding(.horizontal, 116)
        }
        .onChange(of: viewModel.isPresentedPurchaseView,
                  perform: { value in
            if value {
                onNextScreen?()
            }
        })
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct SuccessCreatingAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessCreatingAccountView(viewModel: OnboardingViewModel())
    }
}
