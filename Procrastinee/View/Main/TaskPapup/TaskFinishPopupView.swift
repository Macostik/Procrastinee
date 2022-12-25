//
//  TaskFinishPopupView.swift
//  Procrastinee
//
//  Created by Macostik on 20.12.2022.
//

import SwiftUI

struct TaskFinishPopupView: View {
    @StateObject var viewModel: MainViewModel
    @State var selectedTaskPage = 0
    @State var offset = 0.0
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                Capsule()
                    .foregroundColor(Color.cd9D9D9)
                    .frame(width: 35, height: 4)
                    .padding(.top, 12)
                Spacer()
                HStack {
                    TabView(selection: $selectedTaskPage) {
                        WantToFinishView(viewModel: viewModel) {
                            withAnimation {
                                selectedTaskPage = 1
                            }
                        }.tag(0)
                        AreYouStillInView(viewModel: viewModel)
                        .tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 400)
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
                        viewModel.presentFinishedPopup = !(offset > 200)
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

struct TaskFinishPopupView_Previews: PreviewProvider {
    static var previews: some View {
        TaskFinishPopupView(viewModel: MainViewModel())
    }
}
