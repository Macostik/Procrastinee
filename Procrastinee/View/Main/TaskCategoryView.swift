//
//  TaskCategoryView.swift
//  Procrastinee
//
//  Created by Macostik on 19.12.2022.
//

import SwiftUI

struct TaskCategoryView: View {
    @StateObject var viewModel: MainViewModel
    @State var offset = 0.0
    var body: some View {
        ZStack {
            VStack {
                if viewModel.isTaskCategoryPresented {
                    contentView
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .animation(.easeInOut, value: viewModel.isTaskCategoryPresented)
        .shadow(color: Color.black.opacity(0.1), radius: 16, y: -10)
    }
}
extension TaskCategoryView {
    var contentView: some View {
        VStack(spacing: 0) {
            Capsule()
                .foregroundColor(Color.cd9D9D9)
                .frame(width: 35, height: 4)
                .padding(.top, 12)
            HeaderView()
            TaskPickerView()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 594)
        .background(Color.cf8Fafb)
        .offset(y: self.offset)
        .gesture(DragGesture()
            .onChanged { gesture in
                let yOffset = gesture.location.y
                if yOffset > 0 {
                    offset = yOffset
                }
            }
            .onEnded { _ in
                withAnimation {
                    self.viewModel.isTaskCategoryPresented = !(offset > 200)
                    self.offset = 0
                }
            }
        )
        .clipShape(RoundedCorner(radius: 30,
                                 corners: [.topLeft, .topRight]))
    }
}

struct TaskCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCategoryView(viewModel: MainViewModel())
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(L10n.Task.category)
                .font(.system(size: 28).weight(.bold))
                .foregroundColor(Color.c253456)
            Text(L10n.Task.setCategory)
                .font(.system(size: 18).weight(.medium))
                .foregroundColor(Color.cadadad)
                .padding(.top, 6)
        }
        .padding(.top, 44)
    }
}

struct TaskPickerView: View {
    @State var selectTask = TaskType.sport
    var body: some View {
        VStack {
            Picker("", selection: $selectTask) {
                ForEach(TaskType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.wheel)
            .highPriorityGesture(DragGesture())
        }
    }
}
