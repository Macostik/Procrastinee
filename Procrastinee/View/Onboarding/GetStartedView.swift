//
//  GetStartedView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI

struct GetStartedView: View {
    var onNextScreen: (() -> Void)?
    var body: some View {
        ZStack {
            Image.getStarted
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 55)
                .offset(y: -9)
            VStack {
                Spacer()
                GradientButton(action: {
                    onNextScreen?()
                }, label: {
                    Text(L10n.Onboarding.getStarted)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                })
            }
            .padding(.horizontal, 23)
            .padding(.bottom, 35)
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
