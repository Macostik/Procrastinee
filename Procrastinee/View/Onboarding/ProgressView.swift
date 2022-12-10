//
//  ProgressView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct ProgressView: View {
    @State private var isPresentSuccessCreatingAccount = false
    var body: some View {
        VStack {
            Text(L10n.Onboarding.creatingProfile)
                .font(.system(size: 14).weight(.medium))
                .foregroundColor(Color.onboardingTextColor)
            ProgressBarView(progress: 0.6)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.isPresentSuccessCreatingAccount = true
            })
        }
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
