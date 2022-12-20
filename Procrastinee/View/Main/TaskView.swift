//
//  TaskView.swift
//  Procrastinee
//
//  Created by Macostik on 19.12.2022.
//

import SwiftUI

struct TaskView: View {
    @StateObject var viewModel: MainViewModel
    var body: some View {
        ZStack {
            VStack {
                if viewModel.isTaskCategoryPresented {
                    TaskCreatePopupView(viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                } else if viewModel.isFinished {
                    TaskFinishPopupView(viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .animation(.easeInOut, value: viewModel.isTaskCategoryPresented)
        .animation(.easeInOut, value: viewModel.isFinished)
        .shadow(color: Color.black.opacity(0.1), radius: 16, y: -10)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(viewModel: MainViewModel())
    }
}
