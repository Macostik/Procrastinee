//
//  OnboardingView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//
import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel: OnboardingViewModel
    @State private var screenType: OnboardingScreensType = .getStarted
    var body: some View {
        GeometryReader { proxy in
            NavigationLink("", destination: MainView(), isActive: $viewModel.isPresentedMainView)
            ScrollViewReader { reader in
                VStack {
                    ScrollableScrollView(scrollDisable: true) {
                        ListScreenView(viewModel: viewModel, screenType: $screenType)
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
        OnboardingView(viewModel: OnboardingViewModel())
    }
}

struct ListScreenView: View {
    @StateObject var viewModel: OnboardingViewModel
    @Binding var screenType: OnboardingScreensType
    var body: some View {
        Group {
            GetStartedView {
                screenType = .suggested
            }
            .id(OnboardingScreensType.getStarted)
            SuggestedView {
                screenType = .introducing
            }
            .id(OnboardingScreensType.suggested)
            IntroducingView {
                screenType = .reminder
            }
            .id(OnboardingScreensType.introducing)
            RemindersView {
                screenType = .createProfile
            }
            .id(OnboardingScreensType.reminder)
            CreateProfileView(viewModel: viewModel) {
                screenType = .progress
            }
            .id(OnboardingScreensType.createProfile)
            ProgressView(viewModel: viewModel) {
                screenType = .successCreated
            }
            .id(OnboardingScreensType.progress)
            SuccessCreatingAccountView(viewModel: viewModel) {
                screenType = .purchase
            }
            .id(OnboardingScreensType.successCreated)
            PurchaseView(onboardingViewModel: viewModel)
            .id(OnboardingScreensType.purchase)
        }
    }
}
