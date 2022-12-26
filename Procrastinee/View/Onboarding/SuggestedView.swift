//
//  SuggestedView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI

struct SuggestedView: View {
    var onNextScreen: (() -> Void)?
    var body: some View {
        VStack {
            Image.suggested
                .resizable()
                .frame(width: 157, height: 136)
            Group {
                Text(L10n.Onboarding.forBetter)
                    .font(.system(size: 18)
                        .weight(.light)) +
                Text(L10n.Onboarding.turnAudioOn)
                    .font(.system(size: 18)
                        .weight(.medium)) +
                Text(L10n.Onboarding.or)
                    .font(.system(size: 18)
                        .weight(.light)) +
                Text(L10n.Onboarding.useHeadphones)
                    .font(.system(size: 18)
                        .weight(.medium))
            }
            .foregroundColor(Color.onboardingTextColor)
            .multilineTextAlignment(.center)
            .font(.system(size: 18))
            .padding(.top, 19)
            .padding(.horizontal, 50)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                onNextScreen?()
            })
        }
        .offset(y: -12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct SuggestedView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestedView()
    }
}
