//
//  ContainerPlanningView.swift
//  Procrastinee
//
//  Created by Macostik on 21.12.2022.
//

import SwiftUI
import AVFoundation

let horizontalPadding: CGFloat = 20

struct ContainerPlanningView: View {
    @Environment(\.screenSize) private var screenSize
    @StateObject var viewModel: MainViewModel
    @State var showPlusButton = true
    var body: some View {
        ZStack(alignment: .top) {
            if  viewModel.groupTask.count == 1 &&
                    viewModel.groupTask.first?.value.isEmpty ?? true {
                VStack {
                    Spacer()
                    Text(L10n.Task.noting)
                        .font(.system(size: 16).weight(.regular))
                        .foregroundColor(Color.cb7B7B7)
                        .offset(y: -42)
                    Spacer()
                }
            }
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.groupTask, id: \.self) { item in
                    Section(header:
                                TaskSectionHeader(viewModel: viewModel,
                                                  index: item.index,
                                                  date: item.value.first?.timestamp ??
                                                  Date().timeIntervalSince1970,
                                                  title: item.key)) {
                        VStack(spacing: 13) {
                            ForEach(item.value, id: \.self) { task in
                                TaskCell(task: task)
                                    .frame(height: 110)
                            }
                        }
                    }
                }
                Color.clear
                    .frame(width: screenSize.width, height: 20)
            }
            .padding(.top, 0)
        }
        .fullScreenSize()
    }
}

struct ContainerPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerPlanningView(viewModel: MainViewModel())
    }
}

struct TaskSectionHeader: View {
    @StateObject var viewModel: MainViewModel
    @State var player: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Open Prize",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    var index: Int
    var date: TimeInterval
    var title: String
    var body: some View {
        HStack(spacing: 16) {
            let componentDay = date.getDay()
                .replacingOccurrences(of: ",", with: "")
                .split(separator: " ")
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color.cf2F2F2)
                .frame(width: 48, height: 56)
                .overlay {
                    VStack {
                        Text(String(componentDay[2]))
                            .font(.system(size: 20).weight(.bold))
                            .foregroundColor(Color.black)
                        Text(componentDay[1])
                            .font(.system(size: 12).weight(.bold))
                            .foregroundColor(Color.ccfcfcf)
                    }
                }
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.black)
                Text(String(componentDay[0]))
                    .font(.system(size: 12).weight(.bold))
                    .foregroundColor(Color.ccfcfcf)
            }
            Spacer()
            if viewModel.groupTask.first?.key == title {
                Button {
                    viewModel.isTaskCategoryPresented = true
                    player?.play()
                    UIImpactFeedbackGenerator(style: .soft)
                        .impactOccurred()
                } label: {
                    Image.plusIcon
                }
                .padding(.trailing, -7)
            }
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, 10)
        .frame(height: 128, alignment: .bottom)
        .background(Color.backgroundColor)
    }
}

struct TaskCell: View {
    var task: TaskItem
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 9)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, y: 4)
                .overlay {
                    HStack {
                        DesctriptionTaskView(task: task)
                        Spacer()
                        task.taskImage
                    }
                    .padding(.horizontal, 18)
                }
        }
        .padding(.horizontal, horizontalPadding)
    }
}

struct DesctriptionTaskView: View {
    var task: TaskItem
    var body: some View {
        let forTime = task.forTime.components(separatedBy: ":")
        VStack(alignment: .leading, spacing: 0) {
            Text(task.name.capitalized)
                .font(.system(size: 16).weight(.semibold))
                .foregroundColor(Color.black)
            HStack(spacing: 0) {
                Group {
                    Text(L10n.Task.from) +
                    Text(task.fromTime) +
                    Text(" ")
                }
                .font(.system(size: 12).weight(.medium))
                .foregroundColor(Color.ccfcfcf)
                if task.state == "completed" {
                    Group {
                        Text(" ")
                        Text(L10n.Task.for)
                            .font(.system(size: 12).weight(.medium))
                            .foregroundColor(Color.black)
                        Text(forTime.first ?? "")
                            .font(.system(size: 12).weight(.medium))
                            .foregroundColor(Color.black)
                        Text("h ")
                            .font(.system(size: 12).weight(.light))
                            .foregroundColor(Color.black)
                        Text(forTime.last ?? "")
                            .font(.system(size: 12).weight(.medium))
                            .foregroundColor(Color.black)
                        Text("m")
                            .font(.system(size: 12).weight(.light))
                            .foregroundColor(Color.black)
                    }
                }
            }
            .padding(.top, 5)
            if task.state == "planned" {
                Text(task.state.capitalized)
                    .font(.system(size: 15).weight(.light))
                    .foregroundColor(Color.black)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 12)
                    .background(Color.cf9F9F9)
                    .cornerRadius(9)
                    .padding(.top, 19)
            } else {
                Text(task.state.capitalized)
                    .font(.system(size: 15).weight(.light))
                    .foregroundStyle(gradient)
                    .background(Color.cf9F9F9)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 12)
                    .background(Color.cf9F9F9)
                    .cornerRadius(9)
                    .padding(.top, 19)
            }
        }
    }
}
