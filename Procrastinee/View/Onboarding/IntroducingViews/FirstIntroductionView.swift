//
//  FirstIntroductionView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI

struct FirstIntroductionView: View {
    @State private var isPresentedSecondIntroductionView = false
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image.firstIntroduction
                .resizable()
                .frame(width: 327, height: 196)
                .scaledToFit()
            Group {
                Text(L10n.Onboarding.hey)
                    .font(.system(size: 18)
                        .weight(.light)) +
                Text(L10n.Onboarding.stoping)
                    .font(.system(size: 18)
                        .weight(.medium)) +
                Text(L10n.Onboarding.weJustWant)
                    .font(.system(size: 18)
                        .weight(.light))
            }
            .padding(.top, 63)
            .foregroundColor(Color.onboardingTextColor)
            .padding(.horizontal, 24)
            Spacer()
        }
        .padding(.bottom, 36)
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct FirstIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        FirstIntroductionView()
    }
}
