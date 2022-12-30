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
    @StateObject var viewModel: OnboardingViewModel
    @Environment(\.dependency) private var dependency
    @State private var userExist = false
    @State var player: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Planning Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
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
                                    viewModel.isCountyPopupPresented = true
                                }
                            } label: {
                                let flag = viewModel.selectedCountry.components(separatedBy: " ").first ?? ""
                                Text(flag)
                            }
                            Image.countrySelectedIcon
                            Divider()
                                .padding(.vertical, 19)
                                .padding(.horizontal, 11)
                            TextField(L10n.Onboarding.nickname, text: $viewModel.nickName)
                                .foregroundColor(Color.onboardingTextColor)
                                .font(.system(size: 18))
                                .accentColor(Color.c2F2E41)
                                .focused($isFocused)
                                .onTapGesture {
                                    viewModel.isCountyPopupPresented = false
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
                    .padding(.top, viewModel.isCountyPopupPresented ? -40 : 40)
                    .shadow(color: Color.shadowColor, radius: 30)
                Spacer()
                GradientButton(action: {
                    isFocused = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        UIImpactFeedbackGenerator(style: .soft)
                            .impactOccurred()
                        player?.play()
                        userExist = dependency.provider.firebaseService.users
                            .contains(where: { $0.name == viewModel.nickName })
                        if userExist {
                            Logger.warrning(L10n.Onboarding.userExist)
                        } else {
                            dependency.provider.firebaseService
                                .addUser(name: viewModel.nickName,
                                         country: viewModel.selectedCountry,
                                         totalTime: "")
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
                .alert(L10n.Onboarding.userExistTryAnother,
                       isPresented: $userExist) {
                    Button(L10n.Onboarding.ok, role: .cancel) { }
                        }
            }
            if viewModel.isCountyPopupPresented {
                CountryPopupView(viewModel: viewModel)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: viewModel.isCountyPopupPresented)
            }
        }
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(viewModel: OnboardingViewModel())
    }
}
