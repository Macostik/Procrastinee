//
//  CreateProfileView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI
import AVFoundation
import HYSLogger

struct CreateProfileView: View {
    @FocusState private var isFocused: Bool
    @StateObject private var keyboard = KeyboardHandler()
    @StateObject var mainViewModel: MainViewModel
    @StateObject var onboardingViewModel: OnboardingViewModel
    @Environment(\.dependency) private var dependency
    @State private var userExist = false
    var onNextScreen: (() -> Void)?
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
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
                            Button {
                                withAnimation {
                                    isFocused = false
                                    onboardingViewModel.isCountyPopupPresented = true
                                }
                            } label: {
                                let code = onboardingViewModel.selectedCountry.components(separatedBy: "_").last ?? ""
                                Text(emojiFlag(by: code))
                            }
                            Image.countrySelectedIcon
                            Divider()
                                .padding(.vertical, 19)
                                .padding(.horizontal, 11)
                            TextField(L10n.Onboarding.nickname, text: $onboardingViewModel.nickName)
                                .foregroundColor(Color.onboardingTextColor)
                                .font(.system(size: 18))
                                .accentColor(Color.c2F2E41)
                                .focused($isFocused)
                                .onTapGesture {
                                    onboardingViewModel.isCountyPopupPresented = false
                                    isFocused = true
                                }
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                        isFocused = true
                                    })
                                }
                        }
                        .padding(.horizontal, 14)
                    }
                    .frame(height: 66)
                    .padding(.horizontal, 28)
                    .padding(.top, onboardingViewModel.isCountyPopupPresented ? -40 : 40)
                    .shadow(color: Color.shadowColor, radius: 30)
                Spacer()
                GradientButton(action: {
                    isFocused = false
                    mainViewModel.mainplayer?.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        UIImpactFeedbackGenerator(style: .soft)
                            .impactOccurred()
                        userExist = dependency.provider.firebaseService.users.value
                            .contains(where: { $0.name == onboardingViewModel.nickName }) ||
                        onboardingViewModel.nickName.isEmpty
                        if userExist {
                            Logger.warrning(L10n.Onboarding.userExist)
                        } else {
                            dependency.provider.firebaseService
                                .addUser(name: onboardingViewModel.nickName,
                                         country: onboardingViewModel.selectedCountry)
                            onNextScreen?()
                        }
                    })
                }, label: {
                    HStack {
                        Image.checkmark
                        Text(L10n.Onboarding.create)
                            .foregroundColor(Color.white)
                            .font(.system(size: 17)
                                .weight(.bold))
                    }
                    .disabled(userExist)
                })
                .padding(.horizontal, 23)
                .padding(.bottom, 20)
                .alert(onboardingViewModel.nickName.isEmpty ?
                       L10n.Onboarding.nicknameEmpty :
                       L10n.Onboarding.userExistTryAnother,
                       isPresented: $userExist) {
                    Button(L10n.Onboarding.ok, role: .cancel) { }
                        }
            }
            if onboardingViewModel.isCountyPopupPresented {
                CountryPopupView(viewModel: onboardingViewModel)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: onboardingViewModel.isCountyPopupPresented)
            }
        }
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(mainViewModel: MainViewModel(),
                          onboardingViewModel: OnboardingViewModel())
    }
}
