//
//  TrackerView.swift
//  Procrastinee
//
//  Created by Macostik on 15.12.2022.
//

import SwiftUI

struct TrackerView: View {
    @State private var dealType: DealType = .tracker
    @State private var selectedTracker: TrackerType = .tracker
    var body: some View {
        VStack(spacing: 0) {
            TrackerPlaningSwitcher(dealType: $dealType)
            TimerView()
            TipsView()
            StatisticView()
            MainSegmentControl(isRightCornerRounded: selectedTracker == .tracker)
                .onTapGesture {
                    selectedTracker = selectedTracker == .tracker ? .runking : .tracker
                }
            Spacer()
        }
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
    }
}

struct TrackerPlaningSwitcher: View {
    @Binding var dealType: DealType
    var body: some View {
        HStack(spacing: 30) {
            Button {
            } label: {
                Text(L10n.Main.tracker)
                    .font(.system(size: 15).weight(.regular))
                    .foregroundColor(Color.c2F2E41)
            }
            Button {
            } label: {
                Text(L10n.Main.planing)
                    .font(.system(size: 15).weight(.regular))
                    .foregroundColor(Color.c878787)
            }
        }
        .offset(x: dealType == .tracker ? 40 : -40)
        .padding(.top, 17)
    }
}

struct TimerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image.tapToStart
                .offset(y: 20)
            ZStack {
                TickView()
                LinePath()
                    .stroke(Color.c2F2E41,
                            style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                Image.polygon
                    .resizable()
                    .frame(width: 65, height: 70)
                    .offset(x: 10)

            }
            .frame(width: 311, height: 311, alignment: .center)
        }
    }
}

struct TickView: View {
    var body: some View {
        ForEach(0..<60) { tick in
            self.tick(at: tick)
        }
    }
    private func tick(at tick: Int) -> some View {
        VStack {
            Rectangle()
                .fill(Color.primary)
                .frame(width: 2, height: 7)
            Spacer()
        }.rotationEffect(Angle.degrees(Double(tick)/(28) * 360))
    }
}

struct LinePath: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect.insetBy(dx: 25, dy: 25))
        return path
    }
}

struct TipsView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image.groupDots
            HStack {
                Image.slideLeft
                Spacer()
            }
            .padding(.top, 25)
        }
        .padding(.horizontal, 14)
        .padding(.top, 97)
    }
}

struct StatisticView: View {
    @State private var todayFocusValue = "1h43m"
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(L10n.Main.todayFocused)
                    .font(.system(size: 12).weight(.semibold))
                    .foregroundColor(Color.c2F2E41) +
                Text(todayFocusValue)
                    .font(.system(size: 12).weight(.semibold))
                    .foregroundColor(Color.mainTextColor)
                Text(L10n.Main.dailyAverage)
                    .font(.system(size: 12).weight(.semibold))
                    .foregroundColor(Color.c2F2E41) +
                Text(todayFocusValue)
                    .font(.system(size: 12).weight(.semibold))
                    .foregroundColor(Color.mainTextColor)
            }
            HStack(alignment: .top, spacing: -10) {
                Text(L10n.Main.totalWeekly)
                    .font(.system(size: 12).weight(.semibold))
                    .foregroundColor(Color.c2F2E41)
                VStack(spacing: 0) {
                    Text(todayFocusValue)
                        .font(.system(size: 12).weight(.semibold))
                        .foregroundColor(Color.mainTextColor)
                    Image.underLine
                        .resizable()
                        .frame(width: 60, height: 50)
                        .offset(y: -17)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 24)
    }
}

struct MainSegmentControl: View {
    var isRightCornerRounded = true
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color.ceaeaea)
                .frame(width: 210, height: 31)
                .overlay(content: {
                    ZStack {
                        Color.white
                            .clipShape(
                                RoundedCorner(radius: 15,
                                              corners: isRightCornerRounded ?
                                              [.topLeft, .bottomLeft] :
                                                [.topRight, .bottomRight])
                            )
                            .frame(width: 105, height: 31)
                            .offset(x: isRightCornerRounded ? -53 : 52)
                            .shadow(color: Color.black.opacity(0.25), radius: 15)
                        Text(L10n.Main.tracker)
                            .font(.system(size: 12).weight(.semibold))
                            .offset(x: -52)
                        Text(L10n.Main.ranking)
                            .font(.system(size: 12).weight(.semibold))
                            .offset(x: 52)
                    }
                })
                .padding(.top, 4)
        }
    }
}
