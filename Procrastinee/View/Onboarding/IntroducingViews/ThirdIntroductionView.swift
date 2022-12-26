//
//  ThirdIntroductionView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct ThirdIntroductionView: View {
    @State private var isPresentedKeepYourTrackView = false
    var body: some View {
        VStack {
            NavigationLink(destination: RemindersView(),
                           isActive: $isPresentedKeepYourTrackView) {}
            Spacer()
            Image.thirdIntroduction
                .resizable()
                .frame(width: 334, height: 304)
                .scaledToFit()
            Group {
                Text(L10n.Onboarding.thirdIntroduction)
                    .font(.system(size: 17.5)
                        .weight(.light)) +
                Text(L10n.Onboarding.stopProcrastinating)
                    .font(.system(size: 17.5)
                        .weight(.medium)) +
                Text(L10n.Onboarding.becomeMoreSuccessful)
                    .font(.system(size: 17.5)
                        .weight(.light)) +
                Text(L10n.Onboarding.proactive)
                    .font(.system(size: 17.5)
                        .weight(.medium)) +
                Text(L10n.Onboarding.andMost)
                    .font(.system(size: 17.5)
                        .weight(.light)) +
                Text(L10n.Onboarding.motivated)
                    .font(.system(size: 17.5)
                        .weight(.medium)) +
                Text(L10n.Onboarding.also)
                    .font(.system(size: 17.5)
                        .weight(.light))
            }
                .foregroundColor(Color.onboardingTextColor)
                .padding(.top, 34)
                .padding(.horizontal, 20)
            Spacer()
        }
        .padding(.bottom, 34)
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct ThirdIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdIntroductionView()
    }
}
