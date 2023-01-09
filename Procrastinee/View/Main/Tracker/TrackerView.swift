//
//  TrackerView.swift
//  Procrastinee
//
//  Created by Macostik on 23.12.2022.
//

import SwiftUI
import AVFoundation

let endCycleValue: CGFloat = 269
let beginCycleValue: CGFloat = -89
let dotsCount = 8

struct TrackerView: View {
    @StateObject var viewModel: MainViewModel
    @State private var canDrag = false
    var body: some View {
        VStack(spacing: 0) {
            TrackerPlaningSwitcher(viewModel: viewModel, type: $viewModel.selectedDeal)
            VStack {
                GeometryReader { proxy in
                    PagerView(pageCount: 2, canDrag: $canDrag,
                              currentIndex: $viewModel.pickerViewSelectedIndex) {
                        Group {
                            ContainerTrackerView(viewModel: viewModel)
                                .id(DealType.tracker)
                                .opacity(viewModel.selectedDeal == .planning ? 0 : 1)
                            ContainerPlanningView(viewModel: viewModel)
                                .id(DealType.planning)
                        }
                        .frame(width: proxy.size.width,
                               height: proxy.size.height)
                    }
                }
            }
        }
        .onDisappear {
            viewModel.hasSlidToLeft = true
        }
        .background(Color.cf8Fafb)
        TaskPopoverPresenterView(viewModel: viewModel)
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView(viewModel: MainViewModel())
    }
}

struct TrackerPlaningSwitcher: View {
    @StateObject var viewModel: MainViewModel
    @Binding var type: DealType
    var body: some View {
        HStack(spacing: 30) {
            Button {
                viewModel.secondaryPlayer?.play()
                type = .tracker
            } label: {
                Text(L10n.Main.tracker)
                    .font(.system(size: 15).weight(.regular))
                    .foregroundColor(type == .tracker ?
                                     Color.c2F2E41 : Color.c878787)
            }
            Button {
                viewModel.secondaryPlayer?.play()
                type = .planning
            } label: {
                Text(L10n.Main.planing)
                    .font(.system(size: 15).weight(.regular))
                    .foregroundColor(type == .planning ?
                                     Color.c2F2E41 : Color.c878787)
            }
        }
        .offset(x: type == .tracker ? 50 : -50)
        .animation(.easeInOut, value: type)
        .padding(.top, 66)
    }
}

struct TimerView: View {
    @StateObject var viewModel: MainViewModel
    @State var isScale = false
    var clickHandler: (() -> Void)?
    var body: some View {
        VStack(alignment: .leading) {
            Image.tapToStart
                .offset(y: 20)
                .opacity(UserDefaults.standard.bool(forKey: Constants.tapToStart) ? 0 : 1)
                .zIndex(1)
            ZStack {
                LinePath()
                    .stroke(Color.c2F2E41,
                            style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                ZStack {
                    TickView()
                        .scaleEffect(isScale ? 0.94 : 1.0)
                        .animation(.interactiveSpring(), value: isScale)
                    if viewModel.isTrackStarted {
                        if viewModel.hasTaskPaused {
                            Circle()
                                .foregroundColor(Color.gray)
                                .frame(width: 230, height: 230)
                            Image.pause
                                .resizable()
                                .frame(width: 52, height: 58)
                                .zIndex(2)
                                .onTapGesture {
                                    viewModel.hasTaskPaused = false
                                }
                        }
                        GradientCircleView(startInitValue: $viewModel.counter)
                            .fill(viewModel.isBreakingTime ? promodoroGradient : gradient)
                            .frame(width: 230, height: 230, alignment: .center)
                            .rotationEffect(Angle(degrees: -CGFloat(viewModel.counter/2) - 45))
                            .onReceive(viewModel.timer) { _ in
                                if viewModel.hasTaskPaused == false {
                                    if viewModel.isDeepMode {
                                        viewModel.focusPlayer?.numberOfLoops = .max
                                        viewModel.focusPlayer?.play()
                                    }
                                    viewModel.counterDots += 1
                                    let currentSeconds = Int(viewModel.counterDots * viewModel.interval)
                                    let index =
                                    Int(currentSeconds/(viewModel.stopWatchingTrackingTime * 60/dotsCount))
                                    viewModel.progressDots = index
                                    if viewModel.counter >= endCycleValue {
                                        // reverse animation
                                        viewModel.isReverseAnimation = true
                                        viewModel.isTrackShouldStop = true
                                        viewModel.isBreakingTimeShouldStop = viewModel.isBreakingTime
                                    } else if viewModel.counter <= beginCycleValue {
                                        // begin animation
                                        viewModel.isBreakingTime =
                                        viewModel.isReverseAnimation &&
                                        !viewModel.isBreakingTimeShouldStop &&
                                        viewModel.selectedTrackerType == .promodoro
                                        viewModel.isReverseAnimation = false
                                        if viewModel.isTrackShouldStop {
                                            viewModel.counterDots = 0
                                            viewModel.isTrackShouldStop = false
                                            viewModel.isBreakingTimeShouldStop = false
                                        }
                                    }
                                    viewModel.counter = viewModel.isReverseAnimation ?
                                    viewModel.counter - 1/smoothAnimationValue :
                                    viewModel.counter + 1/smoothAnimationValue
                                }
                            }
                            .onReceive(viewModel.timeCounterTimer) { _ in
                                if viewModel.selectedTrackerType == .promodoro {
                                    if viewModel.isBreakingTime == false {
                                        viewModel.todayFocusedValue += 1
                                        viewModel.totalWeeklyValue += 1
                                        viewModel.dailyAverageValue = viewModel.totalWeeklyValue/7
                                    }
                                } else {
                                    if viewModel.hasTaskPaused == false {
                                        viewModel.todayFocusedValue += 1
                                        viewModel.totalWeeklyValue += 1
                                        viewModel.dailyAverageValue = viewModel.totalWeeklyValue/7
                                    }
                                }
                            }
                    } else {
                        Button {
                            isScale = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                clickHandler?()
                                isScale = false
                                viewModel.counter = beginCycleValue - 0.9
                                UIImpactFeedbackGenerator(style: .soft)
                                    .impactOccurred()
                                viewModel.hasTappedToStart = true
                            }
                        } label: {
                            Image.polygon
                                .resizable()
                                .frame(width: 65, height: 70)
                                .offset(x: 10)
                        }
                    }
                }
            }
            .background(Color.backgroundColor)
            .onTapGesture {
                if viewModel.selectedTrackerType == .stopWatch {
                    viewModel.hasTaskPaused = true
                    UIImpactFeedbackGenerator(style: .soft)
                        .impactOccurred()
                    viewModel.focusPlayer?.pause()
                    viewModel.secondaryPlayer?.play()
                }
            }
            .onLongPressGesture(perform: {
                viewModel.mainplayer?.play()
                UIImpactFeedbackGenerator(style: .soft)
                    .impactOccurred()
                viewModel.presentFinishedPopup = true
                viewModel.hasTappedToHold = true
            })
            .frame(width: 326, height: 326, alignment: .center)
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
                .fill(Color.c2F2E41)
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
    @StateObject var viewModel: MainViewModel
    var body: some View {
        VStack(spacing: 0) {
            DotsProgressView(dotsCount: dotsCount,
                             selectedIndex: $viewModel.progressDots)
                .offset(x: 6)
            HStack {
                Image.slideLeft
                    .opacity(UserDefaults.standard
                        .bool(forKey: Constants.slideToLeft) ? 0 : 1 )
                Spacer()
            }
            .padding(.top, 25)
        }
        .padding(.horizontal, 14)
    }
}
struct TipsImageView: View {
    @StateObject var viewModel: MainViewModel
    var body: some View {
        HStack {
            Image.tapToPause
                .opacity((UserDefaults.standard.bool(forKey: Constants.tapToPause) ||
                         viewModel.selectedTrackerType == .promodoro) ? 0 : 1)
            Spacer()
            Image.tapToHold
                .opacity(UserDefaults.standard.bool(forKey: Constants.tapToHold) ? 0 : 1)
        }
        .padding(.horizontal, 10)
        .opacity(viewModel.isTrackStarted ? 1 : 0)
    }
}

struct StatisticView: View {
    @StateObject var viewModel: MainViewModel
    var body: some View {
        ZStack(alignment: .top) {
            HStack(alignment: .bottom, spacing: 0) {
                Text(L10n.Main.todayFocused)
                    .font(.system(size: 12).weight(.semibold))
                    .foregroundColor(Color.c2F2E41)
                let todayFocusedValue = "\(viewModel.todayFocusedValue.hour)" + "h " +
                "\(viewModel.todayFocusedValue.minute)" + "m"
                Text(todayFocusedValue)
                    .font(.system(size: 12).weight(.semibold))
                    .foregroundStyle(gradientVertical)
            }
            .opacity(viewModel.isTrackStarted ? 1 : 0)
            VStack(spacing: 5) {
                HStack {
                    HStack(alignment: .bottom, spacing: 0) {
                        Text(L10n.Main.todayFocused)
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundColor(Color.c2F2E41)
                        let todayFocusedValue = "\(viewModel.todayFocusedValue.hour)" + "h " +
                        "\(viewModel.todayFocusedValue.minute)" + "m"
                        Text(todayFocusedValue)
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundStyle(gradientVertical)
                    }
                    HStack(alignment: .bottom, spacing: 0) {
                        Text(L10n.Main.dailyAverage)
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundColor(Color.c2F2E41)
                        let dailyAverageValue = "\(viewModel.dailyAverageValue.hour)" + "h " +
                        "\(viewModel.dailyAverageValue.minute)" + "m"
                        Text(dailyAverageValue)
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundStyle(gradientVertical)
                    }
                }
                HStack(alignment: .top, spacing: -10) {
                    Text(L10n.Main.totalWeekly)
                        .font(.system(size: 12).weight(.semibold))
                        .foregroundColor(Color.c2F2E41)
                    VStack(spacing: 0) {
                        let totalWeekly = "\(viewModel.totalWeeklyValue.hour)" + "h " +
                        "\(viewModel.totalWeeklyValue.minute)" + "m"
                        Text(totalWeekly)
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundStyle(gradientVertical)
                            .offset(x: 5)
                        Image.underLine
                            .resizable()
                            .frame(width: 60, height: 50)
                            .offset(y: -17)
                    }
                }
            }
            .opacity(viewModel.isTrackStarted ? 0 : 1)
        }
        .padding(.horizontal, 14)
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
                            .foregroundColor(Color.c2F2E41)
                        Text(L10n.Main.ranking)
                            .font(.system(size: 12).weight(.semibold))
                            .offset(x: 52)
                            .foregroundColor(Color.c2F2E41)
                    }
                })
                .padding(.top, 4)
        }
    }
}

struct GradientCircleView: Shape {
    @Binding var startInitValue: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addArc(center: .init(x: rect.midX, y: rect.midY),
                    radius: rect.width/2,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: startInitValue),
                    clockwise: true)
        return path
    }
}
