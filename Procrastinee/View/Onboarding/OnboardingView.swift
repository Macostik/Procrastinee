//
//  OnboardingView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//
import SwiftUI

struct OnboardingView: View {
    @StateObject var onboardingViewModel: OnboardingViewModel
    @StateObject var mainViewModel: MainViewModel
    @State private var screenType: OnboardingScreensType = .suggested
    var body: some View {
        GeometryReader { proxy in
            NavigationLink("", destination: MainView(viewModel: mainViewModel),
                           isActive: $onboardingViewModel.isPresentedMainView)
            ScrollViewReader { reader in
                VStack {
                    ScrollableScrollView(scrollDisable: true) {
                        ListScreenView(mainViewModel: mainViewModel,
                                       onboardingViewModel: onboardingViewModel,
                                       screenType: $screenType)
                            .frame(width: proxy.size.width,
                                   height: proxy.size.height)
                    }
                }
                .onChange(of: screenType) { newValue in
                    withAnimation {
                        reader.scrollTo(newValue)
                    }
                }
            }
        }
        .background(Color.backgroundColor)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingViewModel: OnboardingViewModel(),
                       mainViewModel: MainViewModel())
    }
}

struct ListScreenView: View {
    @StateObject var mainViewModel: MainViewModel
    @StateObject var onboardingViewModel: OnboardingViewModel
    @Binding var screenType: OnboardingScreensType
    var body: some View {
        Group {
            SuggestedView {
                screenType = .introducing
            }
            .id(OnboardingScreensType.suggested)
            IntroducingView(viewModel: mainViewModel) {
                screenType = .reminder
            }
            .id(OnboardingScreensType.introducing)
            RemindersView(viewModel: mainViewModel) {
                screenType = .createProfile
            }
            .id(OnboardingScreensType.reminder)
            CreateProfileView(mainViewModel: mainViewModel,
                              onboardingViewModel: onboardingViewModel) {
                screenType = .progress
            }
            .id(OnboardingScreensType.createProfile)
            ProgressView(viewModel: onboardingViewModel) {
                screenType = .successCreated
            }
            .id(OnboardingScreensType.progress)
            SuccessCreatingAccountView(viewModel: onboardingViewModel) {
                screenType = .purchase
            }
            .id(OnboardingScreensType.successCreated)
            PurchaseView(mainViewModel: mainViewModel,
                         onboardingViewModel: onboardingViewModel)
            .id(OnboardingScreensType.purchase)
        }
    }
}
