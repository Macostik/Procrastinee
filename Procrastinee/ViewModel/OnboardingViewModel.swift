//
//  OnboardingViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import Foundation
import Combine

enum OnboardingScreensType: String {
    case suggested,
         introducing,
         reminder,
         createProfile,
         progress,
         successCreated,
         purchase
}

enum IntroducingViewType: String {
    case first, second, third, finish
    mutating func goToNext() {
        switch self {
        case .first: self = .second
        case .second: self = .third
        case .third: self = .finish
        case .finish: self = .finish
        }
    }
}

class OnboardingViewModel: ObservableObject {
    @Published var isPresentedMainView = false
    @Published var isPresentedPurchaseView = false
    @Published var isPresentedProgressBarView = false
    @Published var isCountyPopupPresented = false
    @Published var selectedCountry = "Ukraine_UA" 
    @Published var isPresentedSuccessCreatingAccount = false {
        willSet {
            if newValue {
                cancellable = Timer.publish(every: 2, on: .main, in: .default)
                    .autoconnect()
                    .receive(on: DispatchQueue.main)
                    .map({ _ in true })
                    .assign(to: \.isPresentedPurchaseView, on: self)
            }
        }
    }
    @Published var nickName = "" {
        willSet {
            if newValue.isEmpty == false {
                UserDefaults.standard.set(newValue,
                                          forKey: Constants.userNickname)
            }
        }
    }
    var cancellable: Cancellable?
    init() {
        isPresentedMainView =
        UserDefaults.standard.bool(forKey: Constants.authorised)
    }
}

extension OnboardingViewModel {
    func purchaseProduct() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            let userDefaults = UserDefaults.standard
            let isUserAuthorised = !(userDefaults.string(forKey: Constants.userNickname)?.isEmpty ?? false)
            UserDefaults.standard.set(isUserAuthorised,
                                      forKey: Constants.authorised)
            self.isPresentedMainView = isUserAuthorised
        })
    }
}
