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
        ZStack {
            TimerView(viewModel: viewModel) {
                if viewModel.hasTaskPaused == false {
                    viewModel.isTaskCategoryPresented = true
                }
            }
            .offset(y: -183)
            TipsImageView(viewModel: viewModel)
                .offset(y: 40)
            TipsView(viewModel: viewModel)
                .offset(y: 143)
            StatisticView(viewModel: viewModel)
                .offset(y: 244)
        }
    }
}

struct ContainerTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerTrackerView(viewModel: MainViewModel())
    }
}
