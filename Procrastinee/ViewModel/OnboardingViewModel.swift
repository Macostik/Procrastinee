//
//  OnboardingViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var isPresentSuggestedView = false {
        willSet {
            if newValue {
                presentFirstIntroductionViewAfterDelay()
            }
        }
    }
    @Published var isPresentFirstIntroductionView = false
    @Published var isPresentSecondIntroductionView = false
    @Published var isPresentThirdIntroductionView = false
    func presentFirstIntroductionViewAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.isPresentFirstIntroductionView = true
        })
    }
}
