//
//  TrackerSettingsView.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import SwiftUI
import AVFoundation

struct TrackerSettingsView: View {
    @StateObject var viewModel: MainViewModel
    private var isPromodoroSelected: Bool {
        viewModel.selectedTrackerType == .promodoro
    }
    var body: some View {
        VStack(spacing: 0) {
            SegmentControlTrackerView(viewModel: viewModel,
                                      selectedTracker: $viewModel.selectedTrackerType)
            if isPromodoroSelected {
                BreakTimeView(viewModel: viewModel)
            }
            DeepFocusModeView(isKeepingFocus: $viewModel.isDeepMode,
                              isPromodoroSelected: isPromodoroSelected)
            FocusSoundsView(isPromodoroSelected: isPromodoroSelected)
            Spacer()
        }
        .onDisappear {
            viewModel.hasSlidToLeft = true
        }
        .fullScreenSize()
    }
}

struct TrackerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerSettingsView(viewModel: MainViewModel())
    }
}

struct BreakTimeView: View {
    @StateObject var viewModel: MainViewModel
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Text(L10n.Tracking.Settings.breakTime)
                    .font(.system(size: 20).weight(.semibold))
                    .foregroundColor(Color.c2F2E41)
                Text(L10n.Tracking.Settings.takeRest)
                    .font(.system(size: 15).weight(.light))
                    .foregroundColor(Color.settingsTextColor)
                    .padding(.top, 4)
            }
            СarouselView(dataList: Array(1...10), selectedValue: $viewModel.breakTime)
                .padding(.top, 50)
        }
        .padding(.top, 16)
    }
}

struct DeepFocusModeView: View {
    @Binding var isKeepingFocus: Bool
    @State var playerOn: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Tracker from Planning Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    @State var playerOff: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Planning Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    var isPromodoroSelected: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            Text(L10n.Tracking.Settings.deepMode)
                .font(.system(size: 20).weight(.semibold))
                .foregroundColor(Color.c2F2E41)
            Text(L10n.Tracking.Settings.keepApp)
                .font(.system(size: 15).weight(.light))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.settingsTextColor)
                .padding(.top, 4)
            Button {
                isKeepingFocus.toggle()
                if isKeepingFocus {
                    playerOn?.play()
                } else {
                    playerOff?.play()
                }
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            } label: {
                Text(isKeepingFocus ?
                     L10n.Tracking.Settings.on : L10n.Tracking.Settings.off)
                    .font(.system(size: 17).weight(.bold))
                    .foregroundColor(Color.white)
                    .frame(width: 150, height: 50)
                    .background(backgroundView(isKeepingFocus))
                    .cornerRadius(14)
            }
            .padding(.top, 18)
        }
        .padding(.top, isPromodoroSelected  ? 30 : 74)
    }
}

struct FocusSoundsView: View {
    var isPromodoroSelected: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(L10n.Tracking.Settings.focusSound)
                .font(.system(size: 20).weight(.semibold))
                .foregroundColor(Color.c2F2E41)
            HStack(spacing: 22) {
                ForEach(soundList) { sound in
                    SoundView(sound: sound)
                }
            }
            .padding(.top, 19)
        }
        .padding(.top, isPromodoroSelected ? 54 : 78)
    }
}

@ViewBuilder func backgroundView(_ isKeepingFocus: Bool) -> some View {
    if isKeepingFocus {
       gradient
    } else {
        Color.grayColor
    }
}
