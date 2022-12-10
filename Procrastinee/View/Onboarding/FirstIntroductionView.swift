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
        VStack {
            NavigationLink(destination: SecondIntroductionView(),
                           isActive: $isPresentedSecondIntroductionView) {}
            Image.procrasteeImage
                .resizable()
                .frame(width: 138, height: 32)
                .scaledToFit()
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
                        .weight(.bold)) +
                Text(L10n.Onboarding.weJustWant)
                    .font(.system(size: 18)
                        .weight(.light))
            }
            .foregroundColor(Color.onboardingTextColor)
            .padding(.top, 63)
            .padding(.horizontal, 24)
            Spacer()
            GradientButton(action: {
                isPresentedSecondIntroductionView = true
            }, label: {
                HStack {
                    Image.arrow
                    Text(L10n.Onboarding.continue)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                }
            })
            PageIndicatorView()
                .padding(.top, 12)
                .padding(.bottom, 40)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct FirstIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        FirstIntroductionView()
    }
}
