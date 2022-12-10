//
//  CreateProfileView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct CreateProfileView: View {
    @StateObject var keyboard = KeyboardHandler()
    @State private var isPresentedProgressBarView = false
    @State private var nickName = ""
    var body: some View {
        VStack {
            NavigationLink(destination: CreateProfileView(),
                           isActive: $isPresentedProgressBarView) {}
            Text(L10n.Onboarding.setYourName)
                .font(.system(size: 28).weight(.bold))
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            Text(L10n.Onboarding.toCreateProfile)
                .font(.system(size: 18).weight(.medium))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.gray.opacity(0.3))
                .padding(.horizontal, 90)
                .padding(.top, -10)
            Spacer()
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(Color.white)
                .overlay {
                    HStack {
                        Image(systemName: "rectangle.tophalf.filled")
                        Image.countrySelectedIcon
                        Divider()
                            .padding(.vertical, 19)
                            .padding(.horizontal, 11)
                        TextField(L10n.Onboarding.nickname, text: $nickName)
                            .font(.system(size: 18))
                    }
                    .padding(.horizontal, 14)
                }
                .frame(height: 66)
                .padding(.horizontal, 28)
                .shadow(color: Color.shadowColor, radius: 30)
                .offset(y: -100)
            Spacer()
            GradientButton(action: {
                isPresentedProgressBarView = true
            }, label: {
                HStack {
                    Image.checkmark
                    Text(L10n.Onboarding.create)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                }
            })
            .offset(y: -keyboard.height - (keyboard.height > 0 ? 15 : 66))
        }
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView()
    }
}
