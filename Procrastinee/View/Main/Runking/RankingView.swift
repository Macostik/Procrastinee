//
//  RankingView.swift
//  Procrastinee
//
//  Created by Macostik on 23.12.2022.
//

import SwiftUI
import AVFoundation

struct RankingView: View {
    @State var isPresentTopRankingView = false
    @StateObject var viewModel: MainViewModel
    var body: some View {
        VStack(spacing: 0) {
            Text(L10n.Ranking.weekly)
                .font(.system(size: 15).weight(.regular))
                .foregroundColor(Color.c2F2E41)
                .padding(.top, 62)
            Button {
                isPresentTopRankingView = true
                UIImpactFeedbackGenerator(style: .soft)
                    .impactOccurred()
            } label: {
                TopRankingHeader(viewModel: viewModel)
            }
            TopListView()
        }
        .background(Color.cf2F2F2)
        .sheet(isPresented: $isPresentTopRankingView) {
            TopRankingView(viewModel: viewModel)
        }
        .onAppear {
            endInWeek()
        }
    }
    func endInWeek() {
        let endOfWeek = Date().endOfWeek ?? Date()
        let diffs = Calendar.current.dateComponents([.day, .hour, .minute],
                                                    from: Date(),
                                                    to: endOfWeek)
        let day = diffs.day ?? 0
        let hour = diffs.hour ?? 0
        let minutes = diffs.minute ?? 0
        viewModel.weekEndInValue = "\(day)" + "d:" + "\(hour)" + "h:" + "\(minutes)" + "m"
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView(viewModel: MainViewModel())
    }
}

struct TopRankingHeader: View {
    @StateObject var viewModel: MainViewModel
    var body: some View {
        RoundedRectangle(cornerRadius: 9)
            .frame(maxWidth: .infinity, maxHeight: 100)
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
                                Text(viewModel.weekEndInValue)
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
    @Environment(\.dependency) private var dependency
    var body: some View {
        let dataList = dependency.provider.firebaseService.users.value
            .sorted(by: { $0.totalWeekly > $1.totalWeekly })
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(Array(dataList.enumerated()), id: \.offset) { index, user in
                        TopListCell(index: index, user: user)
                    }
                }
            }
            Color.clear
                .frame(width: screenSize.width, height: 20)
        }
        .padding(.top, 18)
    }
}

struct TopListCell: View {
    let index: Int
    let user: User
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 9)
                .foregroundColor(Color.white)
                .overlay {
                    HStack {
                        Text("\(index + 1).")
                            .font(.system(size: 16).weight(.semibold))
                            .foregroundColor(Color.black)
                        HStack(spacing: -10) {
                            Text(user.name)
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color.black)
                                .padding(.leading, 15)
                           let flag = user.country.components(separatedBy: " ").first ?? ""
                            Text(flag)
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color.black)
                                .padding(.leading, 15)
                        }
                        Spacer()
                        UserTotalTime(index: index, user: user)
                    }
                    .padding(.horizontal, 15)
                }
        }
        .frame(height: 75)
        .padding(.horizontal, 15)
        .shadow(color: Color.c2F2E41.opacity(0.1), radius: 10)
    }
}

struct UserTotalTime: View {
    var index: Int
    var user: User
    var body: some View {
        if index == 0 {
            VStack(spacing: 5) {
                ZStack(alignment: .topTrailing) {
                    Image.topOne
                        .resizable()
                        .frame(width: 43, height: 27)
                    Circle()
                        .frame(width: 17, height: 17)
                        .foregroundStyle(gradientVertical)
                        .overlay {
                            Text("3")
                                .font(.system(size: 12).weight(.bold))
                                .foregroundColor(Color.white)
                        }
                }
                HStack(spacing: 5) {
                    HStack(spacing: 0) {
                        Text("\(user.totalWeekly.hour)")
                            .font(.system(size: 14).weight(.medium))
                            .foregroundStyle(gradientVertical)
                        Text("h")
                            .font(.system(size: 14).weight(.medium))
                            .foregroundColor(Color.black)
                    }
                    HStack(spacing: 0) {
                        Text("\(user.totalWeekly.minute)")
                            .font(.system(size: 14).weight(.medium))
                            .foregroundStyle(gradientVertical)
                        Text("m")
                            .font(.system(size: 14).weight(.medium))
                            .foregroundColor(Color.black)
                    }
                }
            }
        } else {
            HStack(spacing: 5) {
                HStack(spacing: 0) {
                    Text("\(user.totalWeekly.hour)")
                        .font(.system(size: 14).weight(.medium))
                        .foregroundStyle(gradientVertical)
                    Text("h")
                        .font(.system(size: 14).weight(.medium))
                        .foregroundColor(Color.black)
                }
                HStack(spacing: 0) {
                    Text("\(user.totalWeekly.minute)")
                        .font(.system(size: 14).weight(.medium))
                        .foregroundStyle(gradientVertical)
                    Text("m")
                        .font(.system(size: 14).weight(.medium))
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}
