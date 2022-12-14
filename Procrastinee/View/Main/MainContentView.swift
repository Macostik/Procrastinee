//
//  MainContentView.swift
//  Procrastinee
//
//  Created by Macostik on 15.12.2022.
//

import SwiftUI
import AVFoundation

struct MainContentView: View {
    @StateObject var viewModel: MainViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.selectedTracker == .ranking {
                RankingView(viewModel: viewModel)
            } else {
                TrackerView(viewModel: viewModel)
            }
            MainSegmentControl(isRightCornerRounded: viewModel.selectedTracker == .tracker)
                .onTapGesture {
                    if viewModel.selectedTracker == .tracker {
                        viewModel.selectedTracker = .ranking
                    } else {
                        viewModel.selectedTracker = .tracker
                    }
                    viewModel.mainplayer?.play()
                    UIImpactFeedbackGenerator(style: .soft)
                        .impactOccurred()
                }
                .padding(.bottom, 60)
                .animation(.easeInOut, value: viewModel.isTaskCategoryPresented)
                .animation(.easeInOut, value: viewModel.presentFinishedPopup)
        }
        .fullScreenSize()
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView(viewModel: MainViewModel())
    }
}
