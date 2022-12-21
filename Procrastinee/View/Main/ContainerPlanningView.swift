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
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    ForEach(groupTask, id: \.self) { item in
                        Section(header:
                                    TaskSectionHeader(title: item.key)) {
                            VStack(spacing: 13) {
                                ForEach(item.value, id: \.self) { task in
                                    TaskCell(task: task)
                                        .frame(height: 110)
                                }
                            }
                        }
                    }
                }
            }
            HStack {
                Spacer()
                Image.plusIcon
                    .padding(.top, 49)
            }
            .padding(.trailing, 7)
        }
    }
}

struct ContainerPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerPlanningView(viewModel: MainViewModel())
    }
}

struct TaskSectionHeader: View {
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
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, 22)
        .frame(height: 128, alignment: .bottom)
        .background(Color.backgroundColor)
    }
}

struct TaskCell: View {
    var task: Task
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
