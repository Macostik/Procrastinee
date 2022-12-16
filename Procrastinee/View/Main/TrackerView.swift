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
            SegmentControl(isRightCornerRounded: selectedTracker == .tracker)
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
                    .stroke(Color.c2F2E41, style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                GradientPolygon()
                    .fill(LinearGradient(colors: [Color.startPointColor, Color.endPointColor],
                                         startPoint: .top,
                                         endPoint: .bottom))
                    .frame(width: 65, height: 65)
                    .rotationEffect(Angle(radians: .pi/2))
            }
            .frame(width: 311, height: 311, alignment: .center)
        }
        .padding(.top, 10)
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

struct GradientPolygon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct TipsView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image.groupDots
                .padding(.top, 87)
            HStack {
                Image.slideLeft
                Spacer()
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 25)
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
            Text(L10n.Main.totalWeekly)
                .font(.system(size: 12).weight(.semibold))
                .foregroundColor(Color.c2F2E41) +
            Text(todayFocusValue)
                .font(.system(size: 12).weight(.semibold))
                .foregroundColor(Color.mainTextColor)
        }
        .padding(.horizontal, 14)
        .padding(.top, 25)
    }
}
