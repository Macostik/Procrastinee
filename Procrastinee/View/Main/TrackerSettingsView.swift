//
//  TrackerSettingsView.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import SwiftUI

struct TrackerSettingsView: View {
    @State var selectedTracker: TrackerSettingsType = .promodoro
    @State var isKeepingFocus: Bool = false
    private var isPromodoroSelected: Bool {
        selectedTracker == .promodoro
    }
    var body: some View {
        VStack(spacing: 0) {
            SegmentControlTrackerView(selectedTracker: $selectedTracker)
            if isPromodoroSelected {
                BreakTimeView()
            }
            DeepFocusModeView(isKeepingFocus: $isKeepingFocus,
                              isPromodoroSelected: isPromodoroSelected)
            FocusSoundsView()
            Spacer()
        }
        .fullScreenSize()
    }
}

struct TrackerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerSettingsView()
    }
}

struct BreakTimeView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(L10n.Tracking.Settings.breakTime)
                .font(.system(size: 20).weight(.semibold))
                .foregroundColor(Color.c2F2E41)
            Text(L10n.Tracking.Settings.takeRest)
                .font(.system(size: 15).weight(.light))
                .foregroundColor(Color.settingsTextColor)
                .padding(.top, 4)
            HStack(spacing: 48) {
                Group {
                    Text("3min")
                        .opacity(0.3)
                        .font(.system(size: 28).weight(.thin))
                        .foregroundColor(Color.black)
                    Text("4min")
                        .font(.system(size: 38).weight(.thin))
                        .foregroundColor(Color.black)
                    Text("6min")
                        .opacity(0.3)
                        .font(.system(size: 28).weight(.thin))
                        .foregroundColor(Color.black)
                }
            }
            .padding(.top, 20)
        }
        .padding(.top, 40)
    }
}

struct DeepFocusModeView: View {
    @Binding var isKeepingFocus: Bool
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
            } label: {
                Text(isKeepingFocus ?
                     L10n.Tracking.Settings.on : L10n.Tracking.Settings.off)
                    .font(.system(size: 17).weight(.bold))
                    .foregroundColor(Color.white)
                    .frame(width: 150, height: 50)
                    .background(backgroundView(isKeepingFocus))
                    .cornerRadius(14)
            }
            .padding(.top, 24)
        }
        .padding(.top, isPromodoroSelected  ? 60 : 74)
    }
}

struct FocusSoundsView: View {
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
        .padding(.top, 56)
    }
}

@ViewBuilder func backgroundView(_ isKeepingFocus: Bool) -> some View {
    if isKeepingFocus {
       gradient
    } else {
        Color.grayColor
    }
}
