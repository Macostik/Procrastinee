//
//  MainContentView.swift
//  Procrastinee
//
//  Created by Macostik on 15.12.2022.
//

import SwiftUI
import AVFoundation

struct MainContentView: View {
    @StateObject private var viewModel = MainViewModel()
    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.selectedTracker == .ranking {
                RankingView(viewModel: viewModel)
            } else {
                TrackerView(viewModel: viewModel)
            }
            MainSegmentControl(isRightCornerRounded: viewModel.selectedTracker == .tracker)
                .onTapGesture {
                    viewModel.selectedTracker = viewModel.selectedTracker == .tracker ? .ranking : .tracker
                }
                .padding(.bottom, 80)
                .opacity(viewModel.isTaskCategoryPresented || viewModel.presentFinishedPopup ? 0 : 1)
                .animation(.easeInOut(duration: 0.5), value: viewModel.isTaskCategoryPresented)
                .animation(.easeInOut(duration: 0.5), value: viewModel.presentFinishedPopup)
        }
        .fullScreenSize()
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
