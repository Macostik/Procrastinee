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
            TipsView(isTrackerStarted: $viewModel.isTrackStarted)
            StatisticView(isTrackerStarted: $viewModel.isTrackStarted)
        }
    }
}

struct ContainerTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerTrackerView(viewModel: MainViewModel())
    }
}
