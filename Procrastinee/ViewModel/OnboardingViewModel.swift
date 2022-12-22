//
//  OnboardingViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import Foundation
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var nickName = ""
    @Published var isPresentedMainView = false
    @Published var isPresentedPurchaseView = false
    @Published var isPresentedProgressBarView = false
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
            if code == "UA" {
                countryList.insert(flag, at: 0)
            } else {
                countryList.append(flag)
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
            let isUserAuthorised = true
            UserDefaults.standard.set(isUserAuthorised,
                                      forKey: Constants.authorised)
            self.isPresentedMainView = isUserAuthorised
        })
    }
}
