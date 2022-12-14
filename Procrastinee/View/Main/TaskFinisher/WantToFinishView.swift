//
//  WantToFinishView.swift
//  Procrastinee
//
//  Created by Macostik on 20.12.2022.
//

import SwiftUI
import AVFoundation

struct WantToFinishView: View {
    @StateObject var viewModel: MainViewModel
    var continueClick: (() -> Void)?
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 8) {
                Text(L10n.Task.wantToFinish)
                    .font(.system(size: 28).weight(.bold))
                    .foregroundColor(Color.c253456)
                Text(L10n.Task.ifYouDone)
                    .font(.system(size: 15).weight(.regular))
                    .foregroundColor(Color.cadadad)
                    .multilineTextAlignment(.center)
            }
            VStack {
                GradientButton {
                    viewModel.mainplayer?.play()
                    UIImpactFeedbackGenerator(style: .soft)
                        .impactOccurred()
                    viewModel.presentFinishedPopup = false
                } label: {
                    Text(L10n.Task.continue)
                        .font(.system(size: 17).weight(.bold))
                        .foregroundColor(Color.white)
                }
                RoundedRectangle(cornerRadius: 14)
                    .foregroundColor(Color.ccbcbcb)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .overlay {
                        Text(L10n.Task.finish)
                            .font(.system(size: 17).weight(.bold))
                            .foregroundColor(Color.white)
                    }
                    .onTapGesture {
                        viewModel.secondaryPlayer?.play()
                        UIImpactFeedbackGenerator(style: .soft)
                            .impactOccurred()
                        viewModel.taskIsOver = true
                        viewModel.selectedTask = .sport
                        viewModel.taskName = ""
                        viewModel.updateFinishedTask()
                    }
            }
            .padding(.horizontal, 48)
            .padding(.top, 66)
        }
        .padding(.top, 12)
    }
}

struct WantToFinishView_Previews: PreviewProvider {
    static var previews: some View {
        WantToFinishView(viewModel: MainViewModel())
    }
}
