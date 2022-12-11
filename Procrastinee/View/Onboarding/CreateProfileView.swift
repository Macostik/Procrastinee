//
//  CreateProfileView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct CreateProfileView: View {
    @StateObject private var keyboard = KeyboardHandler()
    @StateObject private var viewModel = OnboardingViewModel()
    var body: some View {
        VStack {
            NavigationLink(destination: ProgressView(viewModel: viewModel),
                           isActive: $viewModel.isPresentedProgressBarView) {}
            Text(L10n.Onboarding.setYourName)
                .font(.system(size: 28).weight(.bold))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .padding(.top, 50)
                .padding(.horizontal, 67)
            Text(L10n.Onboarding.toCreateProfile)
                .font(.system(size: 18).weight(.medium))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.grayColor)
                .padding(.horizontal, 90)
                .padding(.top, -10)
            Spacer()
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(Color.white)
                .overlay {
                    HStack {
                        Text(viewModel.countryList.first ?? "")
                        Image.countrySelectedIcon
                        Divider()
                            .padding(.vertical, 19)
                            .padding(.horizontal, 11)
                        TextField(L10n.Onboarding.nickname, text: $viewModel.nickName)
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
                viewModel.isPresentedProgressBarView = true
            }, label: {
                HStack {
                    Image.checkmark
                    Text(L10n.Onboarding.create)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                }
            })
            .animation(.easeInOut, value: keyboard.height)
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
