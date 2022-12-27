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
    @State var trackerPlayer: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Tracker Tapbar Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    @State var planningPlayer: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Planning Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
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
                        trackerPlayer?.play()
                    } else {
                        viewModel.selectedTracker = .tracker
                        planningPlayer?.play()
                    }
                    UIImpactFeedbackGenerator(style: .soft)
                        .impactOccurred()
                }
                .padding(.bottom, 62)
                .opacity(viewModel.isTaskCategoryPresented || viewModel.presentFinishedPopup ? 0 : 1)
                .animation(.easeInOut(duration: 0.5), value: viewModel.isTaskCategoryPresented)
                .animation(.easeInOut(duration: 0.5), value: viewModel.presentFinishedPopup)
        }
        .fullScreenSize()
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView(viewModel: MainViewModel())
    }
}
