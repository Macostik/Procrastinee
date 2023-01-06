//
//  AreYouStillInView.swift
//  Procrastinee
//
//  Created by Macostik on 20.12.2022.
//

import SwiftUI
import AVFoundation

struct AreYouStillInView: View {
    @StateObject var viewModel: MainViewModel
    @State var player: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Ranking Tapbar Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    @State var finishPlayer: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Finish Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    var body: some View {
        VStack(spacing: 0) {
            PopupFinishHeaderView()
            VStack {
                GradientButton {
                    player?.play()
                    UIImpactFeedbackGenerator(style: .soft)
                        .impactOccurred()
                    viewModel.presentFinishedPopup = false
                } label: {
                    Text(L10n.Task.checkAndContinue)
                        .font(.system(size: 17).weight(.bold))
                        .foregroundColor(Color.white)
                }
                Button {
                    finishPlayer?.play()
                    UIImpactFeedbackGenerator(style: .soft)
                        .impactOccurred()
                    viewModel.taskIsOver = true
                    viewModel.presentFinishedPopup = false
                    viewModel.updateFinishedTask()
                } label: {
                    Text(L10n.Task.finish)
                        .font(.system(size: 17).weight(.bold))
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.ccbcbcb)
                .cornerRadius(14)
            }
            .padding(.top, 30)
            .padding(.horizontal, 48)
        }
    }
}

struct AreYouStillInView_Previews: PreviewProvider {
    static var previews: some View {
        AreYouStillInView(viewModel: MainViewModel())
    }
}

struct PopupFinishHeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(L10n.Task.areYouStill)
                .font(.system(size: 28).weight(.bold))
                .foregroundColor(Color.c253456)
            Text(L10n.Task.everySec)
                .font(.system(size: 15).weight(.regular))
                .foregroundColor(Color.cadadad)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
            Group {
                Text(L10n.Task.showIfDeepMode)
                    .font(.system(size: 11).weight(.regular)) +
                Text(L10n.Task.deepFocusMode)
                    .font(.system(size: 11).weight(.bold)) +
                Text(L10n.Task.is)
                    .font(.system(size: 11).weight(.regular)) +
                Text(L10n.Task.off)
                    .font(.system(size: 11).weight(.light)) +
                Text(L10n.Task.end)
                    .font(.system(size: 11).weight(.regular))
            }
            .foregroundColor(Color.c2F2E41)
            .padding(.top, 3)
        }
        .padding(.top, -8)
    }
}
