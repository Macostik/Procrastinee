//
//  GetStartedView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI

struct GetStartedView: View {
    var isContinueButtonHelper: (() -> Void)?
    var body: some View {
        ZStack {
            Image.getStarted
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 55)
                .frame(alignment: .center)
            VStack {
                Spacer()
                GradientButton(action: {
                  isContinueButtonHelper?()
                }, label: {
                    Text(L10n.Onboarding.getStarted)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                })
            }
            .padding(.horizontal, 23)
            .padding(.bottom, 66)
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
