//
//  PurchaseView.swift
//  Procrastinee
//
//  Created by Macostik on 11.12.2022.
//

import SwiftUI

struct PurchaseView: View {
    @StateObject var viewModel: OnboardingViewModel
    var body: some View {
        VStack {
            Image.procrasteeImage
                .resizable()
                .frame(width: 138, height: 32)
                .scaledToFit()
            Spacer()
            Image.purchase
                .resizable()
                .frame(width: 337, height: 252)
                .scaledToFit()
                .padding(.bottom, 20)
            Text(L10n.Onboarding.chooseYourPlan)
                .font(.system(size: 23).weight(.bold))
            HStack(spacing: 3) {
                ForEach(viewModel.purchaseList,
                        id: \.self) { purchase in
                    PurchaseItem(purchase: purchase)
                }
            }
            .frame(height: 183)
            .padding(.horizontal, 19)
            GradientButton(action: {
                viewModel.purchaseProduct()
            }, label: {
                Text(L10n.Onboarding.tryFree)
                    .font(.system(size: 17).weight(.semibold))
                    .foregroundColor(Color.white)
            })
            .padding(.horizontal, 23)
            .padding(.top, 29)
            Text(L10n.Onboarding.alreadySubscribe)
                .font(.system(size: 16).weight(.light))
                .foregroundColor(Color.grayColor)
                .padding(.top, 1)
                .padding(.bottom, 19)
        }
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView(viewModel: OnboardingViewModel())
    }
}

struct PurchaseItem: View {
    var purchase: Purchasable
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 7)
                .stroke(Color.grayColor, lineWidth: 1)
                .overlay {
                    VStack {
                        Text(purchase.description)
                            .font(.system(size: 17).weight(.semibold))
                            .foregroundColor(Color.onboardingTextColor)
                            .multilineTextAlignment(.center)
                            .padding(.top, 13)
                        Spacer()
                        Text(purchase.price)
                            .font(.system(size: 12).weight(.medium))
                            .foregroundColor(Color.onboardingTextColor)
                            .multilineTextAlignment(.center)
                        Spacer()
                        Divider()
                            .offset(y: 10)
                        Spacer()
                        Text(purchase.averageValue)
                            .font(.system(size: 11).weight(.bold))
                            .foregroundColor(Color.onboardingTextColor)
                            .multilineTextAlignment(.center)
                            .offset(y: 5)
                        Spacer()
                    }
                }
        }
    }
}
