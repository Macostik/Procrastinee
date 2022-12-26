//
//  SecondIntroductionView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct SecondIntroductionView: View {
    var body: some View {
        VStack {
            Spacer()
            Image.secondIntroduction
                .resizable()
                .frame(width: 266, height: 277)
                .scaledToFit()
            Text(L10n.Onboarding.secondIntroduction)
                .font(.system(size: 18).weight(.light))
                .foregroundColor(Color.onboardingTextColor)
                .padding(.top, 34)
                .padding(.horizontal, 22)
            Spacer()
        }
        .padding(.bottom, 88)
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct SecondIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        SecondIntroductionView()
    }
}
