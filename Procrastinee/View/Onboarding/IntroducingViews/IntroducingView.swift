//
//  IntroducingView.swift
//  Procrastinee
//
//  Created by Macostik on 26.12.2022.
//

import SwiftUI
import AVFoundation

struct IntroducingView: View {
    @StateObject var viewModel: MainViewModel
    var onNextScreen: (() -> Void)?
    @State var nextScreen: IntroducingViewType = .first
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { proxy in
                ScrollViewReader { reader in
                    VStack {
                        ScrollableScrollView(scrollDisable: true) {
                            Group {
                                FirstIntroductionView()
                                    .id(IntroducingViewType.first)
                                    .onAppear {
                                        DispatchQueue.main
                                            .asyncAfter(deadline: .now() + 1.5,
                                                                      execute: {
                                            viewModel.isShownContinueButton = true
                                        })
                                    }
                                SecondIntroductionView()
                                    .id(IntroducingViewType.second)
                                    .onAppear {
                                        DispatchQueue.main
                                            .asyncAfter(deadline: .now() + 1.5,
                                                                      execute: {
                                            viewModel.isShownContinueButton = true
                                        })
                                    }
                                ThirdIntroductionView()
                                    .id(IntroducingViewType.third)
                                    .onAppear {
                                        DispatchQueue.main
                                            .asyncAfter(deadline: .now() + 1.5,
                                                                      execute: {
                                            viewModel.isShownContinueButton = true
                                        })
                                    }
                            }
                            
                            .frame(width: proxy.size.width,
                                   height: proxy.size.height)
                        }
                    }
                    .onChange(of: nextScreen) { newValue in
                        withAnimation {
                            reader.scrollTo(newValue)
                        }
                    }
                }
            }
            FooterIntroducingView(viewModel: viewModel) {
                viewModel.mainplayer?.play()
                UIImpactFeedbackGenerator(style: .soft)
                    .impactOccurred()
                nextScreen.goToNext()
                if nextScreen == .finish {
                    onNextScreen?()
                }
            }
        }
    }
}

struct IntroducingView_Previews: PreviewProvider {
    static var previews: some View {
        IntroducingView(viewModel: MainViewModel())
    }
}

struct FooterIntroducingView: View {
    @StateObject var viewModel: MainViewModel
    @State var selected = 1
    var onNextScreen: (() -> Void)?
    var body: some View {
        VStack(spacing: 0) {
            GradientButton(action: {
                onNextScreen?()
                viewModel.isShownContinueButton = false
                selected += 1
            }, label: {
                HStack {
                    Image.arrow
                    Text(L10n.Onboarding.continue)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                }
            })
            .opacity(viewModel.isShownContinueButton ? 1 : 0)
            .padding(.horizontal, 23)
            PageIndicatorView(selected: $selected)
                .padding(.top, 18)
                .padding(.bottom, 10)
        }
    }
}
