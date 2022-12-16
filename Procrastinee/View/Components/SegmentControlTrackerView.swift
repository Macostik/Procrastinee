//
//  SegmentControlTrackerView.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import SwiftUI

struct SegmentControlTrackerView: View {
    @Binding var selectedTracker: TrackerType
    private var isPromodoroSelected: Bool {
        selectedTracker == .promodoro
    }
    var body: some View {
        VStack(spacing: 0) {
            if isPromodoroSelected {
                Text(L10n.Tracking.Settings.promoTracker)
                    .font(.system(size: 20).weight(.semibold))
                Text(L10n.Tracking.Settings.workSet)
                    .font(.system(size: 15).weight(.light))
                    .foregroundColor(Color.settingsTextColor)
                    .padding(.top, 4)
            } else {
                Text(L10n.Tracking.Settings.stopWatchTracker)
                    .font(.system(size: 20).weight(.semibold))
                Text(L10n.Tracking.Settings.workUntil)
                    .font(.system(size: 15).weight(.light))
                    .foregroundColor(Color.settingsTextColor)
                    .padding(.top, 4)
            }
            Capsule()
                .foregroundColor(Color.ceaeaea)
                .frame(width: 136, height: 31)
                .padding(.top, 30)
                .overlay(content: {
                    ZStack {
                        Color.white
                            .clipShape(
                                RoundedCorner(radius: 15,
                                              corners: isPromodoroSelected ?
                                              [.topLeft, .bottomLeft] :
                                                [.topRight, .bottomRight])
                            )
                            .frame(width: 68, height: 31)
                            .offset(x: isPromodoroSelected ? -34 : 34, y: 15)
                            .shadow(color: Color.c2F2E41, radius: 15)
                        Image.clock
                            .offset(x: -34, y: 15)
                        Image.timer
                            .offset(x: 34, y: 15)
                    }
                })
                .onTapGesture {
                    selectedTracker = selectedTracker == .promodoro ? .stopWatch : .promodoro
                }
            if isPromodoroSelected {
                HStack(spacing: 38) {
                    Group {
                        Text("10min")
                            .opacity(0.3)
                            .font(.system(size: 28).weight(.thin))
                        Text("15min")
                            .font(.system(size: 38).weight(.thin))
                        Text("20min")
                            .opacity(0.3)
                            .font(.system(size: 28).weight(.thin))
                    }
                }
                .padding(.top, 35)
            }
        }
        .padding(.top, 60)
    }
}

struct SegmentControlTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
