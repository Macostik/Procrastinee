//
//  TopRankingView.swift
//  Procrastinee
//
//  Created by Macostik on 23.12.2022.
//

import Foundation
import SwiftUI

struct TopRankingView: View {
    @StateObject var viewModel: MainViewModel
    @State var weekEndInValue = "2d:23h:59m"
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button {
                    viewModel.selectedTracker = .tracker
                } label: {
                    Image.closeIcon
                }
            }
            .padding(.trailing, 24)
            .padding(.top, 47)
            Text(L10n.Ranking.system)
                .font(.system(size: 20).weight(.semibold))
                .foregroundColor(Color.c2F2E41)
                .padding(.top, 60)
            VStack {
                Group {
                    Text(L10n.Ranking.youReceive)
                        .font(.system(size: 14).weight(.light))
                        .foregroundColor(Color.c878787) +
                    Text(L10n.Ranking.goldWings)
                        .font(.system(size: 14).weight(.bold))
                        .foregroundColor(Color.c878787) +
                    Text(L10n.Ranking.trophy)
                        .font(.system(size: 14).weight(.light))
                        .foregroundColor(Color.c878787)
                }
                .multilineTextAlignment(.center)
                .foregroundColor(Color.c878787)
                .padding(.top, 5)
            }
            Image.topOne
                .resizable()
                .frame(width: 196, height: 120)
                .padding(.top, 143)
            HStack(spacing: 5) {
                Text(L10n.Ranking.for)
                    .font(.system(size: 24).weight(.light))
                    .foregroundColor(Color.c878787)
                Text(L10n.Ranking.topOne)
                    .font(.system(size: 24).weight(.semibold))
                    .foregroundColor(Color.c878787)
            }
            .padding(.top, 22)
            Spacer()
            HStack(spacing: 5) {
                Group {
                    Text(L10n.Ranking.weeks)
                        .font(.system(size: 17).weight(.bold))
                        .foregroundColor(Color.c2F2E41) +
                    Text(L10n.Ranking.end)
                        .font(.system(size: 17).weight(.regular))
                        .foregroundColor(Color.c2F2E41) +
                    Text(L10n.Ranking.in)
                        .font(.system(size: 17).weight(.bold))
                        .foregroundColor(Color.c2F2E41)
                }
                Text(weekEndInValue)
                    .font(.system(size: 17).weight(.bold))
                    .foregroundColor(Color.c2F2E41)
            }
            .padding(.bottom, 40)
        }
        .navigationBarHidden(true)
        .background(Color.cf8Fafb)
        .fullScreenSize()
    }
}

struct TopRankingView_Previews: PreviewProvider {
    static var previews: some View {
        TopRankingView(viewModel: MainViewModel())
    }
}
