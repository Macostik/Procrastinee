//
//  RemindersView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct RemindersView: View {
    @State private var isPresentedCreateProfileView = false
    var body: some View {
        VStack {
            NavigationLink(destination: CreateProfileView(),
                           isActive: $isPresentedCreateProfileView) {}
            Text(L10n.Onboarding.keepYourTrack)
                .font(.system(size: 28).weight(.bold))
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            Text(L10n.Onboarding.useReminders)
                .font(.system(size: 18).weight(.medium))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.gray.opacity(0.3))
                .padding(.horizontal, 90)
                .padding(.top, -10)
            Spacer()
            Image.reminders
                .resizable()
                .frame(width: 348, height: 217)
                .scaledToFit()
                .offset(y: -40)
            Spacer()
            GradientButton(action: {
                isPresentedCreateProfileView = true
            }, label: {
                HStack {
                    Image.checkmark
                    Text(L10n.Onboarding.yesPlease)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                }
            })
            .padding(.bottom, 66)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}
