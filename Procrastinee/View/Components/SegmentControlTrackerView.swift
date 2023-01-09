//
//  SegmentControlTrackerView.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import SwiftUI
import AVFoundation

struct SegmentControlTrackerView: View {
    @StateObject var viewModel: MainViewModel
    @Binding var selectedTracker: TrackerSettingsType
    private var isPromodoroSelected: Bool {
        selectedTracker == .promodoro
    }
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                if isPromodoroSelected {
                    Text(L10n.Tracking.Settings.promoTracker)
                        .font(.system(size: 20).weight(.semibold))
                        .foregroundColor(Color.c2F2E41)
                    Text(L10n.Tracking.Settings.workSet)
                        .font(.system(size: 15).weight(.light))
                        .foregroundColor(Color.settingsTextColor)
                        .padding(.top, 4)
                } else {
                    Text(L10n.Tracking.Settings.stopWatchTracker)
                        .font(.system(size: 20).weight(.semibold))
                        .foregroundColor(Color.c2F2E41)
                    Text(L10n.Tracking.Settings.workUntil)
                        .font(.system(size: 15).weight(.light))
                        .foregroundColor(Color.settingsTextColor)
                        .padding(.top, 4)
                }
                SegmentControl(isRightCornerRounded: isPromodoroSelected)
                    .onTapGesture {
                        if selectedTracker == .promodoro {
                            selectedTracker = .stopWatch
                        } else {
                            selectedTracker = .promodoro
                        }
                        viewModel.secondaryPlayer?.play()
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                    }
            }
            .padding(.top, 65)
            if isPromodoroSelected {
                СarouselView(dataList: Array(1...12),
                             multiplayValue: 5,
                             selectedValue: $viewModel.workPeriodTime)
                    .padding(.top, 180)
            }
        }
    }
}

struct SegmentControl: View {
    var isRightCornerRounded = true
    var body: some View {
        Capsule()
            .foregroundColor(Color.ceaeaea)
            .frame(width: 136, height: 31)
            .padding(.top, 30)
            .overlay(content: {
                ZStack {
                    Color.white
                        .clipShape(
                            RoundedCorner(radius: 15,
                                          corners: isRightCornerRounded ?
                                          [.topLeft, .bottomLeft] :
                                            [.topRight, .bottomRight])
                        )
                        .frame(width: 68, height: 31)
                        .offset(x: isRightCornerRounded ? -34 : 34, y: 15)
                        .shadow(color: Color.c2F2E4125, radius: 15)
                    Image.clock
                        .offset(x: -34, y: 15)
                    Image.timer
                        .offset(x: 34, y: 15)
                }
            })
    }
}
