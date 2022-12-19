//
//  TaskView.swift
//  Procrastinee
//
//  Created by Macostik on 19.12.2022.
//

import SwiftUI

struct TaskView: View {
    @StateObject var viewModel: MainViewModel
    @State var offset = 0.0
    @State var selectedTask = 0
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

extension TaskView {
    var contentView: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                Capsule()
                    .foregroundColor(Color.cd9D9D9)
                    .frame(width: 35, height: 4)
                    .padding(.top, 12)
                Spacer()
                HStack {
                    if #available(iOS 16.0, *) {
                        TabView(selection: $selectedTask) {
                            TaskCategoryView {
                                withAnimation {
                                    selectedTask = 1
                                }
                            }.tag(0)
                            TaskNameView()
                                .tag(1)
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .scrollDisabled(true)
                    } 
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 594)
            .background(Color.cf8Fafb)
            .offset(y: self.offset)
            .gesture(DragGesture()
                .onChanged({ gesture in
                    if gesture.location.y > 0 &&
                        gesture.startLocation.y < 100 {
                        offset = gesture.translation.height
                    }
                })
                .onEnded({ _ in
                    viewModel.isTaskCategoryPresented = !(offset > 200)
                    offset = 0
                })
            )
            .clipShape(RoundedCorner(radius: 30,
                                     corners: [.topLeft, .topRight]))
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(viewModel: MainViewModel())
    }
}
