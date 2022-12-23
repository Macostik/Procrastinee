//
//  RankingView.swift
//  Procrastinee
//
//  Created by Macostik on 23.12.2022.
//

import SwiftUI

struct RankingView: View {
    @State var isPresentTopRankingView = false
    @StateObject var viewModel: MainViewModel
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: TopRankingView(viewModel: viewModel),
                           isActive: $isPresentTopRankingView,
                           label: {})
            Text(L10n.Ranking.weekly)
                .font(.system(size: 15).weight(.regular))
                .foregroundColor(Color.c2F2E41)
                .padding(.top, 73)
            Button {
                isPresentTopRankingView = true
            } label: {
                TopRankingHeader()
            }
            TopListView()
        }
        .background(Color.cf8Fafb)
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView(viewModel: MainViewModel())
    }
}

struct TopRankingHeader: View {
    @State var totalTime = "2d:23h:59m"
    var body: some View {
        RoundedRectangle(cornerRadius: 9)
            .frame(maxWidth: .infinity, maxHeight: 97)
            .foregroundStyle(gradientVertical)
            .overlay {
                ZStack {
                    VStack {
                        Spacer()
                        HStack {
                            Image.rankingBackground
                            Spacer()
                        }
                    }
                    HStack(spacing: 12) {
                        Image.topOne
                            .resizable()
                            .frame(width: 43, height: 27)
                            .padding(.leading, 24)
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 5) {
                                Text(L10n.Ranking.top)
                                    .font(.system(size: 18).weight(.bold))
                                    .foregroundColor(Color.white)
                                Text(L10n.Ranking.willReceive)
                                    .font(.system(size: 18).weight(.semibold))
                                    .foregroundColor(Color.white)
                            }
                            HStack(spacing: 0) {
                                Text(L10n.Ranking.endsIn)
                                    .font(.system(size: 15).weight(.semibold))
                                    .foregroundColor(Color.white)
                                Text(totalTime)
                                    .font(.system(size: 15).weight(.semibold))
                                    .foregroundColor(Color.white)
                            }
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.top, 42)
    }
}

struct TopListView: View {
    @Environment(\.screenSize) private var screenSize
    let dataList = Array(1...10).map { _ in TopListItem() }
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(Array(dataList.enumerated()), id: \.offset) { index, item in
                        TopListCell(index: index, topListItem: item)
                    }
                }
            }
            Color.clear
                .frame(width: screenSize.width, height: 20)
        }
        .padding(.top, 22)
    }
}

struct TopListCell: View {
    let index: Int
    let topListItem: TopListItem
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 9)
                .foregroundColor(Color.white)
                .overlay {
                    HStack {
                        Text("\(index).")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color.black)
                        Text("Daniel")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color.black)
                            .padding(.leading, 15)
                        Image.checkmark
                            .resizable()
                            .frame(width: 50, height: 50)
                        Spacer()
                        HStack(spacing: 5) {
                            HStack(spacing: 0) {
                                Text("55")
                                    .font(.system(size: 14).weight(.medium))
                                    .foregroundStyle(gradientVertical)
                                Text("h")
                                    .font(.system(size: 14).weight(.medium))
                                    .foregroundColor(Color.black)
                            }
                            HStack(spacing: 0) {
                                Text("37")
                                    .font(.system(size: 14).weight(.medium))
                                    .foregroundStyle(gradientVertical)
                                Text("m")
                                    .font(.system(size: 14).weight(.medium))
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
        }
        .frame(height: 75)
        .padding(.horizontal, 15)
    }
}
