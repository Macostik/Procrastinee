//
//  OnboardingViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import Foundation
import Combine

enum OnboardingScreensType: String {
    case getStarted,
         suggested,
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
    @Published var selectedCountry = ""
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
    var countryList = [String]()
    var cancellable: Cancellable?
    init() {
        setup()
    }
    private func setup() {
        isPresentedMainView =
        UserDefaults.standard.bool(forKey: Constants.authorised)
        for code in NSLocale.isoCountryCodes {
            let flag = emojiFlag(for: code)
            let id = NSLocale
                .localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK")
                .displayName(forKey: NSLocale.Key.identifier, value: id) ?? ""
            if code == "UA" {
                countryList.insert((flag + " " + name), at: 0)
                selectedCountry = (flag + " " + name)
            } else if code == "RU" || code == "BY" {
                continue
            } else {
                countryList.append((flag + " " + name))
            }
        }
    }
}

extension OnboardingViewModel {
    private func emojiFlag(for countryCode: String) -> String {
        func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
            return scalar.value >= 0x61 && scalar.value <= 0x7A
        }
        func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
            precondition(isLowercaseASCIIScalar(scalar))
            return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
        }
        let lowercasedCode = countryCode.lowercased()
        guard lowercasedCode.count == 2 else { return "" }
        guard lowercasedCode.unicodeScalars
            .allSatisfy({ scalar in  isLowercaseASCIIScalar(scalar) })
        else { return "" }
        let indicatorSymbols =
        lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
        return String(indicatorSymbols.map({ Character($0) }))
    }
    func purchaseProduct() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            let userDefaults = UserDefaults.standard
            let isUserAuthorised = !(userDefaults.string(forKey: Constants.userNickname)?.isEmpty ?? false)
            UserDefaults.standard.set(isUserAuthorised,
                                      forKey: Constants.authorised)
            self.isPresentedMainView = isUserAuthorised
        })
    }
}
