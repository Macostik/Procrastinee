//
//  OnboardingViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import Foundation
import Combine

struct CountryType: Hashable {
    var flag: String
    var name: String
}

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
    var countryList: [CountryType] = []
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
            if code == "RU" || code == "BY" || code == "AX" {
                continue
            } else {
                countryList.append(CountryType(flag: flag, name: name))
            }
        }
        countryList.sort(by: { $0.name < $1.name })
        let searchCountry = countryList.first(where: { $0.name.contains("Ukraine") })
        selectedCountry = (searchCountry?.flag ?? "") + " " + (searchCountry?.name ?? "")
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            let userDefaults = UserDefaults.standard
            let isUserAuthorised = !(userDefaults.string(forKey: Constants.userNickname)?.isEmpty ?? false)
            UserDefaults.standard.set(isUserAuthorised,
                                      forKey: Constants.authorised)
            self.isPresentedMainView = isUserAuthorised
        })
    }
}
