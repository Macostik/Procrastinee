//
//  TrackerView.swift
//  Procrastinee
//
//  Created by Macostik on 15.12.2022.
//

import SwiftUI
import AVFoundation

struct TrackerView: View {
    @State private var dealType: DealType = .tracker
    @StateObject private var viewModel = MainViewModel()
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                TrackerPlaningSwitcher(dealType: $dealType)
                TimerView(viewModel: viewModel) {
                    if viewModel.pause == false {
                        viewModel.isTaskCategoryPresented = true
                    }
                }
                TipsView()
                StatisticView()
                MainSegmentControl(isRightCornerRounded: viewModel.selectedTracker == .tracker)
                    .onTapGesture {
                        viewModel.selectedTracker = viewModel.selectedTracker == .tracker ? .runking : .tracker
                    }
                Spacer()
            }
            .background(Color.cf8Fafb)
            TaskView(viewModel: viewModel)
        }
        .edgesIgnoringSafeArea(.bottom)
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
    @StateObject var viewModel: MainViewModel
    @State var reverseAnimation = false
    @State var counter: CGFloat = -89
    var clickHandler: (() -> Void)?
    @State var player: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Play Tracker Buton",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    var body: some View {
        VStack(alignment: .leading) {
            Image.tapToStart
                .offset(y: 20)
            ZStack {
                LinePath()
                    .stroke(Color.c2F2E41,
                            style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                Button {
                    player?.play()
                    clickHandler?()
                } label: {
                    ZStack {
                        TickView()
                        if viewModel.isTrackStarted {
                            if viewModel.pause {
                                Circle()
                                    .foregroundColor(Color.gray)
                                    .frame(width: 219, height: 219)
                                Image.pause
                                    .resizable()
                                    .frame(width: 52, height: 58)
                                    .zIndex(2)
                            }
                            GradientCircleView(startInitValue: $counter)
                                .fill(LinearGradient(colors: [Color.startPointColor, Color.endPointColor],
                                                     startPoint: .leading,
                                                     endPoint: .trailing))
                                .frame(width: 219, height: 219, alignment: .center)
                                .rotationEffect(Angle(degrees: -CGFloat(counter/2) - 45))
                                .onReceive(viewModel.timer) { _ in
                                    if viewModel.pause == false {
                                        if counter >= 269 {
                                            self.reverseAnimation = true
                                        } else if counter <= -89 {
                                            self.reverseAnimation = false
                                        }
                                        counter = self.reverseAnimation ? counter - 1 : counter + 1
                                    }
                                }
                                .onTapGesture {
                                    viewModel.pause.toggle()
                                }
                        } else {
                            Image.polygon
                                .resizable()
                                .frame(width: 65, height: 70)
                                .offset(x: 10)
                        }
                    }
                }
                .buttonStyle(ScaleButtonStyle())
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
