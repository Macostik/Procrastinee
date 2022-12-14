//
//  TaskCategoryView.swift
//  Procrastinee
//
//  Created by Macostik on 19.12.2022.
//

import SwiftUI

struct TaskCategoryView: View {
    @StateObject var viewModel: MainViewModel
    var action: (() -> Void)?
    var body: some View {
        VStack(spacing: 0) {
            TaskCategoryHeaderView()
            PickerTaskView(viewModel: viewModel)
            GradientButton(action: {
                viewModel.mainplayer?.play()
                action?()
            }, label: {
                HStack {
                    Image.checkmark
                    Text(L10n.Task.next)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                }
            })
            .padding(.horizontal, 48)
            .padding(.top, 67)
            Spacer()
        }
    }
}

struct TaskCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCategoryView(viewModel: MainViewModel())
    }
}

struct TaskCategoryHeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(L10n.Task.category)
                .font(.system(size: 28).weight(.bold))
                .foregroundColor(Color.c253456)
            Text(L10n.Task.setCategory)
                .font(.system(size: 18).weight(.medium))
                .foregroundColor(Color.cadadad)
                .multilineTextAlignment(.center)
                .padding(.top, 6)
        }
        .padding(.top, 64)
    }
}

struct PickerTaskView: View {
    @StateObject var viewModel: MainViewModel
    var body: some View {
        Picker("", selection: $viewModel.selectedTask) {
            ForEach(TaskType.allCases, id: \.self) { value in
                Text(value.rawValue.capitalized)
                    .font(.system(size: 23).weight(.medium))
                    .foregroundColor(Color.black)
            }
        }
        .highPriorityGesture(DragGesture())
        .pickerStyle(.wheel)
        .padding(.top, 76)
    }
}
