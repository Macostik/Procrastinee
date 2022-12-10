//
//  OnboardingView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI
struct OnboardingView: View {
    @State private var isPresentedSuggestedView = false
    var body: some View {
        VStack {
            NavigationLink(destination: SuggestedView(),
                           isActive: $isPresentedSuggestedView) {}
            GetStartedView {
                isPresentedSuggestedView = true
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
