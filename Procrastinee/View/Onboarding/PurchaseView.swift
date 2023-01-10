//
//  PurchaseView.swift
//  Procrastinee
//
//  Created by Macostik on 11.12.2022.
//

import SwiftUI
import AVFoundation

struct PurchaseView: View {
    @StateObject var mainViewModel: MainViewModel
    @StateObject var onboardingViewModel: OnboardingViewModel
    @StateObject var purchaseViewModel = PurchaseViewModel()
    @State var isSelectedPurchaseType: PurchaseType = .month
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
                .padding(.bottom, 27)
            Text(L10n.Onboarding.chooseYourPlan)
                .foregroundColor(Color.black)
                .font(.system(size: 23).weight(.bold))
                .padding(.bottom, 12)
            HStack(spacing: 3) {
                ForEach(purchaseViewModel.purchaseList,
                        id: \.self) { purchase in
                    PurchaseItem(purchase: purchase,
                                 isSelected:
                            .constant(purchase.purchaseType == isSelectedPurchaseType))
                        .onTapGesture {
                            mainViewModel.secondaryPlayer?.play()
                            isSelectedPurchaseType = purchase.purchaseType
                        }
                }
            }
            .frame(height: 183)
            .padding(.horizontal, 19)
            .padding(.bottom, 28)
            GradientButton(action: {
                UIImpactFeedbackGenerator(style: .soft)
                    .impactOccurred()
                mainViewModel.mainplayer?.play()
                onboardingViewModel.purchaseProduct()
            }, label: {
                Text(isSelectedPurchaseType == .week ?
                     L10n.Onboarding.subscribe : L10n.Onboarding.tryFree)
                    .font(.system(size: 17).weight(.semibold))
                    .foregroundColor(Color.white)
            })
            .padding(.horizontal, 23)
            .padding(.bottom, 6)
            Text(L10n.Onboarding.alreadySubscribe)
                .font(.system(size: 16).weight(.light))
                .foregroundColor(Color.grayColor)
                .padding(.bottom, 20)
        }
        .padding(.top, 16)
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView(mainViewModel: MainViewModel(),
                     onboardingViewModel: OnboardingViewModel())
    }
}

struct PurchaseItem: View {
    var purchase: Purchase
    @Binding var isSelected: Bool
    var body: some View {
        VStack {
            Group {
                if isSelected {
                    RoundedRectangle(cornerRadius: 7)
                    .stroke(gradientVertical,
                            lineWidth: isSelected ? 2 : 1)
                    .background(Color.backgroundColor)
                    .cornerRadius(7)
                    .shadow(color: Color.black.opacity(0.1), radius: 7)
                } else {
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.grayColor,
                                lineWidth: isSelected ? 2 : 1)
                }
            }
            .overlay {
                    VStack {
                        Text(purchase.purchaseType.description)
                            .font(.system(size: 17).weight(.semibold))
                            .foregroundColor(Color.onboardingTextColor)
                            .multilineTextAlignment(.center)
                            .padding(.top, 13)
                        Spacer()
                        Text(purchase.purchaseType.price)
                            .font(.system(size: 12).weight(.medium))
                            .foregroundColor(Color.onboardingTextColor)
                            .multilineTextAlignment(.center)
                            .offset(y: purchase.purchaseType == .month ? 7 : 0)
                        Spacer()
                        if purchase.purchaseType == .month {
                            HStack(spacing: 5) {
                                VStack {
                                    Divider()
                                        .frame(height: 2)
                                        .background(isSelected ? gradientVertical : nil)
                                        .offset(y: 12)
                                }
                                if isSelected {
                                    RoundedRectangle(cornerRadius: 2)
                                        .foregroundStyle(gradientVertical)
                                        .frame(width: 79, height: 20)
                                        .overlay {
                                            Text(L10n.Onboarding.popular)
                                                .font(.system(size: 11).weight(.medium))
                                                .foregroundColor(Color.white)
                                        }
                                        .offset(y: 12)
                                } else {
                                    RoundedRectangle(cornerRadius: 2)
                                        .foregroundStyle(Color.ccfcfcf)
                                        .frame(width: 79, height: 20)
                                        .overlay {
                                            Text(L10n.Onboarding.popular)
                                                .font(.system(size: 11).weight(.medium))
                                                .foregroundColor(Color.white)
                                        }
                                        .offset(y: 12)
                                }
                                VStack {
                                    Divider()
                                        .frame(height: 2)
                                        .background(isSelected ? gradientVertical : nil)
                                        .offset(y: 12)
                                }
                            }
                        } else {
                            Divider()
                                .frame(height: 2)
                                .background(isSelected ? gradientVertical : nil)
                                .offset(y: 12)
                        }
                        Spacer()
                        if purchase.purchaseType == .month {
                            Text(purchase.purchaseType.averageValue)
                                .font(.system(size: 11).weight(.bold))
                                .foregroundColor(Color.onboardingTextColor)
                                .multilineTextAlignment(.center)
                                .offset(y: 2)
                        } else {
                            Text(purchase.purchaseType.averageValue)
                                .font(.system(size: 11).weight(.bold))
                                .foregroundColor(Color.onboardingTextColor)
                                .multilineTextAlignment(.center)
                                .offset(y: 5)
                        }
                        Spacer()
                    }
                }
        }
        .background(Color.backgroundColor)
        .padding(.top, purchase.purchaseType == .month ? 0 : 11)
    }
}
