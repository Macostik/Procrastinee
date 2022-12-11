//
//  SuccessCreatingAccountView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct SuccessCreatingAccountView: View {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct SuccessCreatingAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessCreatingAccountView()
    }
}
