//
//  SecondIntroductionView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct SecondIntroductionView: View {
    @State private var isPresentedThirdIntroductionView = false
    var body: some View {
        VStack {
            NavigationLink(destination: ThirdIntroductionView(),
                           isActive: $isPresentedThirdIntroductionView) {}
            Image.procrasteeImage
                .resizable()
                .frame(width: 138, height: 32)
                .scaledToFit()
            Spacer()
            Image.secondIntroduction
                .resizable()
                .frame(width: 266, height: 277)
                .scaledToFit()
            Text(L10n.Onboarding.secondIntroduction)
                .font(.system(size: 18).weight(.light))
                .foregroundColor(Color.onboardingTextColor)
                .padding(.top, 34)
                .padding(.horizontal, 24)
            Spacer()
            GradientButton(action: {
                isPresentedThirdIntroductionView = true
            }, label: {
                HStack {
                    Image.arrow
                    Text(L10n.Onboarding.continue)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                }
            })
            .padding(.horizontal, 23)
            PageIndicatorView(selected: 2)
                .padding(.top, 12)
                .padding(.bottom, 40)
        }
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SecondIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        SecondIntroductionView()
    }
}
