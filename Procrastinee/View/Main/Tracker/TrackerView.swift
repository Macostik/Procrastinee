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

struct TrackerView: View {
    @StateObject var viewModel: MainViewModel
    @State private var canDrag = false
    var body: some View {
        VStack(spacing: 0) {
            TrackerPlaningSwitcher(type: $viewModel.selectedDeal)
            VStack {
                GeometryReader { proxy in
                    PagerView(pageCount: 2, canDrag: $canDrag, currentIndex: $viewModel.pickerViewSelectedIndex) {
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
    @State var player: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Play Tracker Buton",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    @Binding var type: DealType
    var body: some View {
        HStack(spacing: 30) {
            Button {
                player?.play()
                type = .tracker
            } label: {
                Text(L10n.Main.tracker)
                    .font(.system(size: 15).weight(.regular))
                    .foregroundColor(type == .tracker ?
                                     Color.c2F2E41 : Color.c878787)
            }
            Button {
                player?.play()
                type = .planning
            } label: {
                Text(L10n.Main.planing)
                    .font(.system(size: 15).weight(.regular))
                    .foregroundColor(type == .planning ?
                                     Color.c2F2E41 : Color.c878787)
            }
        }
        .offset(x: type == .tracker ? 40 : -40)
        .animation(.easeInOut, value: type)
        .padding(.top, 66)
    }
}

struct TimerView: View {
    @StateObject var viewModel: MainViewModel
    @State var reverseAnimation = false
    @State var isScale = false
    var clickHandler: (() -> Void)?
    @State var player: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Play Tracker Buton",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    @State var stopPlayer: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Stop Tracker Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    var body: some View {
        VStack(alignment: .leading) {
            Image.tapToStart
                .offset(y: 20)
                .opacity(viewModel.isTrackStarted ? 0 : 1)
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
                                .frame(width: 219, height: 219)
                            Image.pause
                                .resizable()
                                .frame(width: 52, height: 58)
                                .zIndex(2)
                                .onTapGesture {
                                    viewModel.hasTaskPaused = false
                                    player?.play()
                                    UIImpactFeedbackGenerator(style: .soft)
                                        .impactOccurred()
                                }
                                .onLongPressGesture(perform: {
                                    viewModel.presentFinishedPopup = true
                                })
                        }
                        GradientCircleView(startInitValue: $viewModel.counter)
                            .fill(viewModel.isBreakingTime ? promodoroGradient : gradient)
                            .frame(width: 219, height: 219, alignment: .center)
                            .rotationEffect(Angle(degrees: -CGFloat(viewModel.counter/2) - 45))
                            .onReceive(viewModel.timer) { _ in
                                if viewModel.hasTaskPaused == false {
                                    if viewModel.counter >= endCycleValue {
                                        self.reverseAnimation = true
                                        viewModel.isTrackShouldStop = true
                                        viewModel.isBrackingTimeShouldStop = viewModel.isBreakingTime
                                    } else if viewModel.counter <= beginCycleValue {
                                        viewModel.isBreakingTime =
                                        reverseAnimation &&
                                        viewModel.selectedTrackerType == .promodoro
                                        self.reverseAnimation = false
                                        if viewModel.isTrackShouldStop {
                                            if viewModel.isBreakingTime {
                                                if viewModel.isBrackingTimeShouldStop {
                                                    viewModel.isTrackStarted = false
                                                }
                                            } else {
                                                viewModel.isTrackStarted = false
                                            }
                                            viewModel.isTrackShouldStop = false
                                            viewModel.isBrackingTimeShouldStop = false
                                        }
                                    }
                                    viewModel.counter = self.reverseAnimation ?
                                    viewModel.counter - 1 : viewModel.counter + 1
                                }
                            }
                    } else {
                        Button {
                            isScale = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                player?.play()
                                clickHandler?()
                                isScale = false
                                viewModel.counter = beginCycleValue - 0.9
                                UIImpactFeedbackGenerator(style: .soft)
                                    .impactOccurred()
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
                viewModel.hasTaskPaused = true
                stopPlayer?.play()
                UIImpactFeedbackGenerator(style: .soft)
                    .impactOccurred()
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
    @Binding var isTrackerStarted: Bool
    var body: some View {
        VStack(spacing: 0) {
            if isTrackerStarted {
                HStack {
                    Image.tapToPause
                    Spacer()
                    Image.tapToHold
                }
                .padding(.bottom, 12)
                .padding(.horizontal, 10)
            }
            Image.groupDots
            if !isTrackerStarted {
                HStack {
                    Image.slideLeft
                    Spacer()
                }
                .padding(.top, 25)
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, isTrackerStarted ? -30 : 97)
    }
}

struct StatisticView: View {
    @State private var todayFocusValue = "1h43m"
    @Binding var isTrackerStarted: Bool
    var body: some View {
        VStack(spacing: 5) {
            if isTrackerStarted {
                HStack(alignment: .bottom, spacing: 0) {
                    Text(L10n.Main.todayFocused)
                        .font(.system(size: 12).weight(.semibold))
                        .foregroundColor(Color.c2F2E41)
                    Text(todayFocusValue)
                        .font(.system(size: 12).weight(.semibold))
                        .foregroundStyle(gradient)
                }
                .padding(.bottom, 70)
            } else {
                HStack {
                    HStack(alignment: .bottom, spacing: 0) {
                        Text(L10n.Main.todayFocused)
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundColor(Color.c2F2E41)
                        Text(todayFocusValue)
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundStyle(gradient)
                    }
                    HStack(alignment: .bottom, spacing: 0) {
                        Text(L10n.Main.dailyAverage)
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundColor(Color.c2F2E41)
                        Text(todayFocusValue)
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundStyle(gradient)
                    }
                }
                HStack(alignment: .top, spacing: -10) {
                    Text(L10n.Main.totalWeekly)
                        .font(.system(size: 12).weight(.semibold))
                        .foregroundColor(Color.c2F2E41)
                    VStack(spacing: 0) {
                        Text(todayFocusValue)
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundStyle(gradient)
                        Image.underLine
                            .resizable()
                            .frame(width: 60, height: 50)
                            .offset(y: -17)
                    }
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, isTrackerStarted ? 100 : 24)
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
