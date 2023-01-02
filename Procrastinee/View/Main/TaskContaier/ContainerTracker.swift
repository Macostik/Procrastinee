//
//  ContainerTrackerView.swift
//  Procrastinee
//
//  Created by Macostik on 21.12.2022.
//

import SwiftUI

struct ContainerTrackerView: View {
    @StateObject var viewModel: MainViewModel
    var body: some View {
        VStack(spacing: 0) {
            TimerView(viewModel: viewModel) {
                if viewModel.hasTaskPaused == false {
                    viewModel.isTaskCategoryPresented = true
                }
            }
            TipsView(viewModel: viewModel)
            StatisticView(viewModel: viewModel)
        }
        .padding(.bottom, 100)
    }
}

struct ContainerTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerTrackerView(viewModel: MainViewModel())
    }
}
