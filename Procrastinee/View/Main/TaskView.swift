//
//  TaskView.swift
//  Procrastinee
//
//  Created by Macostik on 19.12.2022.
//

import SwiftUI

struct TaskView: View {
    @StateObject var viewModel: MainViewModel
    @State var selectedTaskPage = 0
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
                    TabView(selection: $selectedTaskPage) {
                        TaskCategoryView {
                            withAnimation {
                                selectedTaskPage = 1
                            }
                        }.tag(0)
                        TaskNameView {
                            viewModel.isTaskCategoryPresented = false
                        }
                        .tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 645)
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
            .clipShape(RoundedCorner(radius: 10,
                                     corners: [.topLeft, .topRight]))
            .onDisappear {
                selectedTaskPage = 0
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(viewModel: MainViewModel())
    }
}
