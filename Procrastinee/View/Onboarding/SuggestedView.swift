//
//  SuggestedView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI

struct SuggestedView: View {
    @StateObject var viewModel: OnboardingViewModel
    var body: some View {
        VStack {
            NavigationLink(destination: FirstIntroductionView(),
                           isActive: $viewModel.isPresentFirstIntroductionView) {}
            Image.suggested
                .resizable()
                .frame(width: 157, height: 136)
            Group {
                Text(L10n.Onboarding.forBetter) +
                Text(L10n.Onboarding.turnAudioOn).bold() +
                Text(L10n.Onboarding.or) +
                Text(L10n.Onboarding.useHeadphones).bold()
            }
            .multilineTextAlignment(.center)
            .font(.system(size: 18))
            .padding(.top, 19)
            .padding(.horizontal, 50)
        }
        .offset(y: -25)
        .navigationBarHidden(true)
    }
}

struct SuggestedView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestedView(viewModel: OnboardingViewModel())
    }
}
