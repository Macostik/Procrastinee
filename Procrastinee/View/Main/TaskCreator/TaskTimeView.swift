//
//  TaskTimeView.swift
//  Procrastinee
//
//  Created by Macostik on 22.12.2022.
//

import SwiftUI
import AVFoundation

struct TaskTimeView: View {
    @Environment(\.screenSize) private var screenSize
    @StateObject var viewModel: MainViewModel
    @State var player: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Tracker Tapbar Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    var body: some View {
        VStack(spacing: 0) {
            TaskTimeHeaderView()
            ZStack {
                RoundedRectangle(cornerRadius: 9)
                    .foregroundColor(Color.cebebeb)
                    .frame(width: screenSize.width - 16, height: 34)
                TimePickerView(selectedTime: $viewModel.selectedTaskTime)
            }
            .padding(.top, 60)
            GradientButton {
                viewModel.createTask(inProcess: false)
                player?.play()
                UIImpactFeedbackGenerator(style: .soft)
                    .impactOccurred()
            } label: {
                HStack {
                    Image.checkmark
                    Text(L10n.Onboarding.create.lowercased().capitalized)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                }
            }
            .padding(.horizontal, 48)
            .padding(.top, 85)
            Spacer()
        }
    }
}

struct TaskTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTimeView(viewModel: MainViewModel())
    }
}

struct TaskTimeHeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(L10n.Task.time)
                .font(.system(size: 28).weight(.bold))
                .foregroundColor(Color.c253456)
            Text(L10n.Task.whenPlanning)
                .font(.system(size: 18).weight(.medium))
                .foregroundColor(Color.cadadad)
                .multilineTextAlignment(.center)
                .padding(.top, 6)
        }
        .padding(.top, 64)
    }
}
