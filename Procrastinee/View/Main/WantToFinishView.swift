//
//  WantToFinishView.swift
//  Procrastinee
//
//  Created by Macostik on 20.12.2022.
//

import SwiftUI

struct WantToFinishView: View {
    @StateObject var viewModel: MainViewModel
    var continueClick: (() -> Void)?
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 8) {
                Text(L10n.Task.wantToFinish)
                    .font(.system(size: 28).weight(.bold))
                    .foregroundColor(Color.c253456)
                Text(L10n.Task.ifYouDone)
                    .font(.system(size: 15).weight(.regular))
                    .foregroundColor(Color.cadadad)
            }
            VStack {
                GradientButton {
                    continueClick?()
                } label: {
                    Text(L10n.Task.continue)
                        .font(.system(size: 17).weight(.bold))
                        .foregroundColor(Color.white)
                }
                Button {
                    viewModel.isFinished = false
                } label: {
                    Text(L10n.Task.finish)
                        .font(.system(size: 17).weight(.bold))
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.ccbcbcb)
                .cornerRadius(14)
            }
            .padding(.horizontal, 48)
            .padding(.top, 66)
        }
        .padding(.top, 12)
    }
}

struct WantToFinishView_Previews: PreviewProvider {
    static var previews: some View {
        WantToFinishView(viewModel: MainViewModel())
    }
}
