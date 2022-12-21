//
//  ContainerPlanningView.swift
//  Procrastinee
//
//  Created by Macostik on 21.12.2022.
//

import SwiftUI

let horizontalPadding: CGFloat = 20

struct ContainerPlanningView: View {
    @StateObject var viewModel: MainViewModel
    var body: some View {
        VStack(spacing: 0) {
            PlusView()
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    ForEach(groupTask, id: \.self) { item in
                        Section(header:
                                    TaskSectionHeader(title: item.key)) {
                            ForEach(item.value, id: \.self) { task in
                                TaskCell(task: task)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
}

struct ContainerPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerPlanningView(viewModel: MainViewModel())
    }
}

struct PlusView: View {
    var body: some View {
        VStack {
            Image.plusIcon
                .resizable()
                .frame(width: 50, height: 50)
        }
    }
}

struct TaskSectionHeader: View {
    @Environment(\.screenSize) private var screenSize
    var title: String
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color.cf2F2F2)
                .frame(width: 48, height: 56)
                .overlay {
                    VStack {
                        Text("30")
                            .font(.system(size: 20).weight(.bold))
                            .foregroundColor(Color.black)
                        Text("Sep")
                            .font(.system(size: 12).weight(.bold))
                            .foregroundColor(Color.ccfcfcf)
                    }
                }
            VStack {
                Text(title)
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.black)
                Text("Friday")
                    .font(.system(size: 12).weight(.bold))
                    .foregroundColor(Color.ccfcfcf)
            }
            Spacer()
        }
        .frame(width: screenSize.width - horizontalPadding * 2, height: 78)
    }
}

struct TaskCell: View {
    @Environment(\.screenSize) private var screenSize
    var task: Task
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 9)
                .frame(width: screenSize.width - horizontalPadding * 2, height: 110)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(0.1),
                        radius: 9)
                .overlay {
                    HStack {
                        DesctriptionTaskView(task: task)
                        Spacer()
                        task.taskImage
                    }
                    .padding(.horizontal, 18)
                }
        }
    }
}

struct DesctriptionTaskView: View {
    var task: Task
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(task.type.rawValue.capitalized)
                .font(.system(size: 16).weight(.semibold))
                .foregroundColor(Color.black)
            HStack {
                Text(task.fromTime)
                    .font(.system(size: 12).weight(.medium))
                    .foregroundColor(Color.ccfcfcf)
                if task.state == .completed {
                    Text(task.forTime)
                        .font(.system(size: 12).weight(.medium))
                        .foregroundColor(Color.ccfcfcf)
                }
            }
            .padding(.top, 5)
            if task.state == .planned {
                Text(task.state.rawValue.capitalized)
                    .font(.system(size: 15).weight(.light))
                    .foregroundColor(Color.black)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 12)
                    .background(Color.cf9F9F9)
                    .cornerRadius(9)
                    .padding(.top, 19)
            } else {
                Text(task.state.rawValue.capitalized)
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
