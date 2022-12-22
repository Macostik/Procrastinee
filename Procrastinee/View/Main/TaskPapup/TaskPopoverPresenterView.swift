//
//  TaskPopoverPresenterView.swift
//  Procrastinee
//
//  Created by Macostik on 19.12.2022.
//

import SwiftUI

struct TaskPopoverPresenterView: View {
    @StateObject var viewModel: MainViewModel
    var body: some View {
        ZStack {
            VStack {
                if viewModel.isTaskCategoryPresented {
                    TaskCreatePopupView(viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                } else if viewModel.presentFinishedPopup {
                    TaskFinishPopupView(viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .animation(.easeInOut, value: viewModel.isTaskCategoryPresented)
        .animation(.easeInOut, value: viewModel.presentFinishedPopup)
        .shadow(color: Color.black.opacity(0.1), radius: 16, y: -10)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskPopoverPresenterView(viewModel: MainViewModel())
    }
}
