//
//  SettingsView.swift
//  Procrastinee
//
//  Created by Macostik on 15.12.2022.
//

import SwiftUI

struct SettingsView: View {
    @State var selectedTracker: TrackerType = .promodoro
    var body: some View {
        VStack(spacing: 0) {
            SegmentControlTrackerView(selectedTracker: $selectedTracker)
                .padding(.top, 60)
            BreakTimeView()
                .padding(.top, 40)
            DeepFocusModeView()
                .padding(.top, 60)
            FocusSoundsView()
                .padding(.top, 56)
            Spacer()
        }
        .fullScreenSize()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct BreakTimeView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(L10n.Tracking.Settings.breakTime)
                .font(.system(size: 20).weight(.semibold))
            Text(L10n.Tracking.Settings.takeRest)
                .font(.system(size: 15).weight(.light))
                .foregroundColor(Color.settingsTextColor)
                .padding(.top, 4)
            HStack(spacing: 48) {
                Group {
                    Text("3min")
                        .opacity(0.3)
                        .font(.system(size: 28).weight(.thin))
                    Text("4min")
                        .font(.system(size: 38).weight(.thin))
                    Text("6min")
                        .opacity(0.3)
                        .font(.system(size: 28).weight(.thin))
                }
            }
            .padding(.top, 20)
        }
    }
}

struct DeepFocusModeView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(L10n.Tracking.Settings.deepMode)
                .font(.system(size: 20).weight(.semibold))
            Text(L10n.Tracking.Settings.keepApp)
                .font(.system(size: 15).weight(.light))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.settingsTextColor)
                .padding(.top, 4)
            Button {
            } label: {
                Text(L10n.Tracking.Settings.off)
                    .font(.system(size: 17).weight(.bold))
                    .foregroundColor(Color.white)
                    .frame(width: 150, height: 50)
                    .background(Color.grayColor)
                    .cornerRadius(14)
            }
            .padding(.top, 24)
        }
    }
}

struct FocusSoundsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(L10n.Tracking.Settings.focusSound)
                .font(.system(size: 20).weight(.semibold))
            HStack(spacing: 22) {
                ForEach(soundList) { sound in
                    SoundView(sound: sound)
                }
            }
            .padding(.top, 19)
        }
    }
}
