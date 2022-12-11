//
//  SuccessCreatingAccountView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct SuccessCreatingAccountView: View {
    @StateObject var viewModel: OnboardingViewModel
    var body: some View {
        VStack {
            NavigationLink(destination: PurchaseView(viewModel: viewModel),
                           isActive: $viewModel.isPresentedPurchaseView) {}
            Image.successMark
            Text(L10n.Onboarding.accountCreateSuccess)
                .font(.system(size: 14).weight(.medium))
                .foregroundColor(Color.onboardingTextColor)
                .multilineTextAlignment(.center)
                .padding(.top, 6)
                .padding(.horizontal, 116)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct SuccessCreatingAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessCreatingAccountView(viewModel: OnboardingViewModel())
    }
}
