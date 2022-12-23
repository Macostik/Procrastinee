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
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
