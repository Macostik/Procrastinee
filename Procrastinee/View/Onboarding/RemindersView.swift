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
            Image.procrasteeImage
                .resizable()
                .frame(width: 138, height: 32)
                .scaledToFit()
            Spacer()
            Image.reminders
                .resizable()
                .frame(width: 348, height: 217)
                .scaledToFit()
            Spacer()
            GradientButton(action: {
                isPresentedCreateProfileView = true
            }, label: {
                HStack {
                    Image.arrow
                    Text(L10n.Onboarding.continue)
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
        CreateProfileView()
    }
}
