//
//  FirstIntroductionView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI

struct FirstIntroductionView: View {
    var body: some View {
        VStack {
            Image.procrasteeImage
                .resizable()
                .frame(width: 138, height: 32)
                .scaledToFit()
            Spacer()
            Image.firstIntroduction
            Group {
                Text(L10n.Onboarding.hey) +
                Text(L10n.Onboarding.stoping).bold() +
                Text(L10n.Onboarding.weJustWant)
            }
            .font(.system(size: 18))
            .padding(.top, 63)
            .padding(.horizontal, 24)
            Spacer()
            GradientButton(action: {
                
            }, label: {
                HStack {
                    Image.arrow
                    Text(L10n.Onboarding.continue)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                }
            })
        }
    }
}

struct FirstIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        FirstIntroductionView()
    }
}
