//
//  IntroducingView.swift
//  Procrastinee
//
//  Created by Macostik on 26.12.2022.
//

import SwiftUI

struct IntroducingView: View {
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
                                SecondIntroductionView()
                                    .id(IntroducingViewType.second)
                                ThirdIntroductionView()
                                    .id(IntroducingViewType.third)
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
            FooterIntroducingView {
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
        IntroducingView()
    }
}

struct FooterIntroducingView: View {
    @State var selected = 1
    var onNextScreen: (() -> Void)?
    var body: some View {
        VStack(spacing: 0) {
            GradientButton(action: {
                onNextScreen?()
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
            .padding(.horizontal, 23)
            PageIndicatorView(selected: $selected)
                .padding(.top, 18)
                .padding(.bottom, 12)
        }
    }
}
